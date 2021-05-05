class RemindersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    interval = Delay.find_by(name: 'req_reconfirmation').value

    sql = %{
      with last_mail as(select c.request_id, max(c.created_at) as max_sent
        from   confirmations c
        group by c.request_id)
      select r.id
      from   requests r
            ,last_mail m
      where  r.id = m.request_id
        and  r.accepted_at is null
        and  r.expired_at is null
        and  current_date > m.max_sent + (#{interval} || ' months')::INTERVAL
    }
    
    reminders = ActiveRecord::Base.connection.exec_query(sql)
    reply_delay = Delay.find_by(name: 'reconfirmation_validity').value

    reminders.each do |reminder|
      SendMailJob.perform_now(reminder["id"], reply_delay)
    end
  end
end
