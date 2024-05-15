# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Questions', type: :request do
  let(:user) { create(:user) }
  let(:valid_params) {
    {
      statement: 'a statement',
      description: 'a description',
      alternatives_attributes: [
        {
          statement: 'alternative statement',
          description: 'alternative description',
          correct: true
        }
      ]
    }
  }

  let(:invalid_params) {
    {
      statement: '',
      description: '',
      alternatives_attributes: [
        {
          statement: '',
          description: '',
          correct: nil
        }
      ]
    }
  }

  before { sign_in user }

  describe 'GET /index' do
    let!(:questions) { create_list(:question, 3) }

    before { get questions_path }

    it 'returns a successful http request' do
      expect(response).to have_http_status(:success)
    end

    it 'returns a list of questions' do
      questions.each do |question|
        expect(response.body).to include(question.statement)
      end
    end
  end

  describe 'GET /new' do
    before { get new_question_path }

    it 'returns a successful http request' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'when parameters are valid' do
      it 'creates a new Question' do
        expect {
          post questions_path, params: { question: valid_params }
        }.to change(Question, :count).by(1)
      end

      it 'redirects to the created question' do
        post questions_path, params: { question: valid_params }
        expect(response).to redirect_to(questions_path)
      end
    end

    context 'when parameters are invalid' do
      it 'does not create a new Question' do
        expect {
          post questions_path, params: { question: invalid_params }
        }.to change(Question, :count).by(0)
      end

      it 'returns an unprocessable entity http response' do
        post questions_path, params: { question: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:question) { create(:question, valid_params) }

    context 'when a question can be destroyed' do
      it 'destroys the requested question' do
        expect {
          delete question_path(question)
        }.to change(Question, :count).by(-1)
      end

      it 'redirects to the questions list' do
        delete question_path(question)
        expect(response).to redirect_to(questions_path)
      end
    end

    context 'when a question cannot be destroyed' do
      before do
        allow_any_instance_of(Question).to receive(:destroy).and_return(false)
      end

      it 'does not destroy the requested question' do
        expect {
          delete question_path(question)
        }.to change(Question, :count).by(0)
      end

      it 'returns an unprocessable entity http response' do
        delete question_path(question)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
