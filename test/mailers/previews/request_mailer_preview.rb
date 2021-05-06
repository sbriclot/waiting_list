# Preview all emails at http://localhost:3000/rails/mailers/request_mailer
class RequestMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/request_mailer/confirmation
  def confirmation
    @confirmation = Confirmation.last
    RequestMailer.with(confirmation: @confirmation, first_mail: true).confirmation
  end

end
