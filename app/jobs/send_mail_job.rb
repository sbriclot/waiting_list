class SendMailJob < ApplicationJob
  queue_as :default

  def perform(request_id, reply_delay)
    @confirmation = Confirmation.create(request_id: request_id,
      validation_key: SecureRandom.hex(16),
      reply_delay: reply_delay
    )
    mail = RequestMailer.with(confirmation: @confirmation).confirmation
    mail.deliver_now
  end
end
