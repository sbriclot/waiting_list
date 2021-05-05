module LogUtils
  def add_log(p_req_id, p_task, p_added_by)
    Log.create(
      request_id: p_req_id,
      task: p_task,
      added_by: p_added_by
    )
  end
end
