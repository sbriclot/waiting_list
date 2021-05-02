class ConfirmationsController < ApplicationController
  def req_confirmation
    @confirmation = Confirmation.find_by(validation_key: params["key"])
    @replied = Time.now
    if @replied.to_date <= @confirmation.created_at.to_date + @confirmation.reply_delay.days
      @confirmation.update(replied_at: @replied)
      Request.update(@confirmation.request_id, confirmed: true)
      redirect_to validated_path
    else
      redirect_to too_late_path
    end
  end
end
