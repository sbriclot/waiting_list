class RequestMailer < ApplicationMailer
  def confirmation
    @confirmation = params[:confirmation]
    @first_mail = params[:first_mail]

    make_bootstrap_mail(
      to: @confirmation.request.email,
      subject: 'Important - Request validation'
    )
  end
end
