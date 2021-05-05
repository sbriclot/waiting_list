class ConfirmationsController < ApplicationController
  include LogUtils
  def confirmation
    @confirmation = Confirmation.find_by(validation_key: params["key"])
    @request = Request.find(@confirmation.request_id)
    @replied = Time.now
    if @replied.to_date <= @confirmation.created_at.to_date + @confirmation.reply_delay.days
      reply_validated
    else
      reply_too_late
    end
  end

  private

  def reply_validated
    @confirmation.update(replied_at: @replied)
    @request.update(confirmed: true)
    add_log(@request.id, "Request validated", "U")
    redirect_to validated_path
  end

  def reply_too_late
    @confirmation.update(replied_at: @replied)
    @request.update(expired_at: @replied) unless @request.expired_at
    add_log(@request.id, "Request canceled by overdelayed reply", "U")
    redirect_to too_late_path
  end
end
