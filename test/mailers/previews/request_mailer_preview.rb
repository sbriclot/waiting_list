# Preview all emails at http://localhost:3000/rails/mailers/request_mailer
class RequestMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/request_mailer/confirmation
  def confirmation
    @reply_delay = Delay.find_by(name: 'confirmation_validity').value
    @confirmation = Confirmation.last
    RequestMailer.with(confirmation: @confirmation, reply_delay: @reply_delay).confirmation
  end

end
