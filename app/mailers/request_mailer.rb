class RequestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.request_mailer.confirmation.subject
  #
  def confirmation
    @confirmation = params[:confirmation]

    make_bootstrap_mail(to: @confirmation.request.email,
      subject: 'Important - Request validation'
    )
  end
end
