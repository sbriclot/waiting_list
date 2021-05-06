class SendMailJob < ApplicationJob
  include LogUtils
  queue_as :default

  def perform(request_id, reply_delay, first_mail)
    @confirmation = Confirmation.create(
      request_id: request_id,
      validation_key: SecureRandom.hex(16),
      reply_delay: reply_delay
    )
    mail = RequestMailer.with(confirmation: @confirmation, first_mail: first_mail).confirmation
    mail.deliver_now
    add_log(request_id, "Mail sent", "J")
  end
end
