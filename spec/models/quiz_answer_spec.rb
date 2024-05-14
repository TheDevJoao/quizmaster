# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuizAnswer, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:quiz) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:question_answers).dependent(:destroy) }
  end

  describe 'validations' do
    context 'when answers are present' do
      subject { build(:quiz_answer, question_answers: [build(:question_answer)]) }

      it 'saves the quiz answer' do
        expect(subject).to be_valid
      end
    end
    context 'when no answers are present' do
      subject { build(:quiz_answer, question_answers: []) }

      before { subject.valid? }

      it 'does not save the quiz answer' do
        expect(subject).to be_invalid
      end

      it 'returns an error message' do
        expect(subject.errors[:base]).to include('Must have answers')
      end
    end
  end
end
