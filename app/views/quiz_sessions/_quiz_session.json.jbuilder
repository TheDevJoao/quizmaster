json.extract! quiz_session, :id, :user_id, :answers, :quiz_snapshot, :result, :created_at, :updated_at
json.url quiz_session_url(quiz_session, format: :json)
