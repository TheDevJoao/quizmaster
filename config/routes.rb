Rails.application.routes.draw do
  devise_for :users
  resources :quizzes
  resources :questions
  resources :quiz_sessions do
    resources :steps, controller: 'quiz_sessions/steps'
  end
  resources :users

  get "up" => "rails/health#show", as: :rails_health_check

  root "quizzes#index"
end
