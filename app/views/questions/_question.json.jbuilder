json.extract! question, :id, :identifier, :statement, :description, :config, :created_at, :updated_at
json.url question_url(question, format: :json)
