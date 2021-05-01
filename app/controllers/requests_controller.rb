class RequestsController < ApplicationController
  def new
    @request = Request.new
    @bio_max_length = Request.validators_on( :bio ).first.options[:maximum]
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      @reply_delay = Delay.find_by(name: 'confirmation_validity').value
      Confirmation.create(request_id: @request.id,
        validation_key: SecureRandom.hex(8),
        reply_delay: @reply_delay
      )
      redirect_to saved_path(delay: @reply_delay)
    else
      render :new
    end
  end

  private

  def request_params
    params.require(:request).permit(:name, :email, :phone, :bio)
  end
end
