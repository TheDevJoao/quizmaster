# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuizQuestion, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:question) }
    it { is_expected.to belong_to(:quiz) }
    it { is_expected.to have_many(:question_answers).dependent(:restrict_with_error) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:weight) }
    it { is_expected.to validate_presence_of(:position) }

    context 'when quiz questions weight are divisible by the number of correct and incorrect alternatives' do
      let(:quiz_question) { build(:quiz_question, weight: 5) }

      it 'saves a valid quiz question' do
        expect(quiz_question).to be_valid
      end
    end

    context 'when quiz questions weight are not divisible by the number of correct and incorrect alternatives' do
      let(:correct_alternatives) { create_list(:alternative, 3, correct: true) }
      let(:incorrect_alternatives) { create_list(:alternative, 2, correct: false) }
      let(:question) { create(:question, alternatives: correct_alternatives + incorrect_alternatives) }
      let(:quiz_question) { build(:quiz_question, question: question, weight: 5) }

      before { quiz_question.valid? }

      it 'returns an error' do
        expect(quiz_question.errors[:base]).to include('Weight must be integer')
      end
    end
  end
end
