json.extract! task, :id, :title, :detail, :due, :status, :remark, :created_at, :updated_at
json.url task_url(task, format: :json)
