class RequestsController < ApplicationController
  def new
    @request = Request.new
    @bio_max_length = Request.validators_on( :bio ).first.options[:maximum]
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      send_mail
    else
      render :new
    end
  end

  private

  def send_mail
    @confirmation = Confirmation.create(request_id: @request.id,
      validation_key: SecureRandom.hex(16),
      reply_delay: Delay.find_by(name: 'confirmation_validity').value
    )
    mail = RequestMailer.with(confirmation: @confirmation).confirmation
    mail.deliver_now
    redirect_to saved_path(delay: @confirmation.reply_delay)
  end

  def request_params
    params.require(:request).permit(:name, :email, :phone, :bio)
  end
end
