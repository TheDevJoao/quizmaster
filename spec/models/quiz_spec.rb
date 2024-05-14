# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Quiz, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:quiz_questions).dependent(:destroy) }
    it { is_expected.to have_many(:questions).through(:quiz_questions) }
    it { is_expected.to have_many(:quiz_answers).dependent(:restrict_with_error) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }

    context 'when no quiz questions are present' do
      subject { build(:quiz, quiz_questions: []) }

      before do
        subject.quiz_questions.clear
        subject.valid?
      end

      it { is_expected.to be_invalid }

      it { expect(subject.errors[:base]).to include('Must have questions') }
    end

    context 'when the sum of the weights of the quiz questions is 100' do
      let(:quiz) { create(:quiz) }

      before { quiz.valid? }

      it 'saves a quiz' do
        expect(quiz).to be_valid
      end

      it 'does not return an error message' do
        expect(quiz.errors[:base]).to be_empty
      end
    end

    context 'when the sum of the weights of the quiz questions is not 100' do
      let(:quiz_question1) { build(:quiz_question, weight: 50) }
      let(:quiz_question2) { build(:quiz_question, weight: 40) }
      let(:quiz) { build(:quiz, quiz_questions: [quiz_question1, quiz_question2]) }

      before { quiz.valid? }

      it 'does not save a quiz' do
        expect(quiz).to be_invalid
      end

      it 'returns an error message' do
        expect(quiz.errors[:base]).to include('Weight must be 100')
      end
    end
  end
end
