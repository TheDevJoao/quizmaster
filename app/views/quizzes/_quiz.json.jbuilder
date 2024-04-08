json.extract! quiz, :id, :identifier, :title, :description, :config, :result_calculator, :created_at, :updated_at
json.url quiz_url(quiz, format: :json)
