# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :quizzes, except: :show do
    resources :quiz_answers, only: %i[new create]
  end
  resources :questions, only: %i[index new create destroy]

  root 'quizzes#index'
end
