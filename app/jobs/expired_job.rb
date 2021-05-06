class ExpiredJob < ApplicationJob
  include LogUtils
  queue_as :default

  def perform
    sql = sql_script

    requests = ActiveRecord::Base.connection.exec_query(sql)

    requests.each do |request|
      Request.find(request["id"]).update(expired_at: Time.now)
      add_log(request["id"], "Request canceled by missing reply", "J")
    end
  end

  def sql_script
    %{
      select r.id
      from   requests r
            ,confirmations c
      where  r.id = c.request_id
        and  r.accepted_at is null
        and  r.expired_at is null
        and  c.replied_at is null
        and  current_date > c.created_at + (c.reply_delay||' days')::INTERVAL
    }
  end
end
