class RequestsController < ApplicationController
  include LogUtils
  BIO_MAX_LENGTH = Request.validators_on( :bio ).first.options[:maximum]

  def new
    @request = Request.new
    @bio_max_length = BIO_MAX_LENGTH
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      add_log(@request.id, "New request added", "U")
      reply_delay = Delay.find_by(name: 'confirmation_validity').value
      SendMailJob.perform_now(@request.id, reply_delay)
      redirect_to saved_path(delay: reply_delay)
    else
      @bio_max_length = BIO_MAX_LENGTH
      render :new
    end
  end

  private

  def request_params
    params.require(:request).permit(:name, :email, :phone, :bio)
  end
end
