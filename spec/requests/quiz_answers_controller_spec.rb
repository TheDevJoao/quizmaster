# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'QuizAnswers', type: :request do
  let(:user) { create(:user) }
  let(:quiz) { create(:quiz) }

  before { sign_in user }

  describe 'GET /new' do

    before { get "/quizzes/#{quiz.id}/quiz_answers/new" }

    it 'returns a successful http request' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:alternative1) { create(:alternative, correct: true) }
    let(:alternative2) { create(:alternative, correct: true) }
    let(:question) { create(:question, alternatives: [alternative1, alternative2]) }
    let(:quiz_question1) { create(:quiz_question, quiz: quiz, question: question, weight: 60) }
    let(:quiz_question2) { create(:quiz_question, quiz: quiz, question: question, weight: 60) }
    let(:quiz_answer_params) {
      {
        quiz_answer: {
          question_answers_attributes: [
            {
              quiz_question_id: quiz_question1.id,
              alternative_id: alternative1.id
            },
            {
              quiz_question_id: quiz_question2.id,
              alternative_id: alternative2.id
            }
          ]
        }
      }
    }

    context 'when creating as json' do
      context 'and a quiz answer is created' do
        before { post "/quizzes/#{quiz.id}/quiz_answers", params: quiz_answer_params, as: :json }

        it 'returns a created http request' do
          expect(response).to have_http_status(:created)
        end
      end

      context 'and a quiz answer is not created' do
        before { post "/quizzes/#{quiz.id}/quiz_answers", params: { quiz_answer: { question_answers_attributes: [] } }, as: :json }

        it 'returns an unprocessable entity http request' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when creating as html' do
      context 'and a quiz answer is created' do
        before { post "/quizzes/#{quiz.id}/quiz_answers", params: quiz_answer_params }

        it 'returns a found http request' do
          expect(response).to have_http_status(:found)
        end
      end

      context 'and a quiz answer is not created' do
        before { post "/quizzes/#{quiz.id}/quiz_answers", params: { quiz_answer: { question_answers_attributes: [] } } }

        it 'returns an unprocessable entity http request' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
