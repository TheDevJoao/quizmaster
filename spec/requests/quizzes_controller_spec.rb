# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuizzesController, type: :request do
  let(:user) { create(:user) }
  let(:quiz) { create(:quiz) }

  let(:valid_attributes) {
    {
      title: 'title',
      description: 'description',
      quiz_questions_attributes: [
        {
          question_id: question1.id,
          weight: 50,
          position: 1
        },
        {
          question_id: question2.id,
          weight: 50,
          position: 2
        }
      ]
    }
  }

  let(:invalid_attributes) {
        {
          title: '',
          description: '',
          quiz_questions_attributes: [
            {
              question_id: nil,
              weight: nil,
              position: nil
            },
            {
              question_id: nil,
              weight: nil,
              position: nil
            }
          ]
        }
      }

  before { sign_in user }

  describe 'GET /index' do
    before { get quizzes_url }
    it 'returns a successful http request' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    before { get new_quiz_url }

    it 'returns a successful http request' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /edit/:id' do
    before { get edit_quiz_url(quiz) }

    it 'returns a successful http request' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update/:id' do
    before { patch quiz_url(quiz), params: { quiz: { title: 'new title', description: 'new description' } } }

    context 'with valid parameters' do
      before { quiz.reload}

      it 'updates the requested quiz' do
        expect(quiz.title).to eq('new title')
      end
    end

    context 'with invalid parameters' do
      before { patch quiz_url(quiz), params: { quiz: { title: '' } } }

      it 'does not update the requested quiz' do
        expect(quiz.title).not_to eq('')
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let(:question1) { create(:question) }
      let(:question2) { create(:question) }

      it 'creates a new Quiz' do
        expect {
          post quizzes_url, params: { quiz: valid_attributes }
        }.to change(Quiz, :count).by(1)
      end

      it 'redirects to the created quiz' do
        post quizzes_url, params: { quiz: valid_attributes }
        expect(response).to redirect_to(quizzes_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Quiz' do
        expect {
          post quizzes_url, params: { quiz: invalid_attributes }
        }.to change(Quiz, :count).by(0)
      end

      it 'returns an unprocessable entity http request' do
        post quizzes_url, params: { quiz: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  #TODO: Add tests for destroy action
end
