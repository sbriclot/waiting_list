class RequestMailer < ApplicationMailer
  def confirmation
    @confirmation = params[:confirmation]

    make_bootstrap_mail(
      to: @confirmation.request.email,
      subject: 'Important - Request validation'
    )
  end
end
