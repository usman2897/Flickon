json.extract! feedback, :id, :user_id, :time_date, :feedback, :created_at, :updated_at
json.url feedback_url(feedback, format: :json)
