# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:quiz_questions).dependent(:restrict_with_error) }
    it { is_expected.to have_many(:quizzes).through(:quiz_questions) }
    it { is_expected.to have_many(:alternatives).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:statement) }

    context 'when there is at least one correct alternative' do
      subject { build(:question) }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'when there are no correct alternatives' do
      subject { build(:question_with_no_correct_alternatives) }

      before { subject.valid? }

      it 'is invalid' do
        expect(subject).to be_invalid
      end

      it 'returns an error message' do
        expect(subject.errors[:base]).to include('Must have alternatives')
      end
    end
  end

  describe '#multiple?' do
    context 'when there is at least one correct alternative' do
      let(:question) { create(:question, alternatives: [correct_alternative, incorrect_alternative]) }
      let(:correct_alternative) { build(:alternative, :correct_alternative) }
      let(:incorrect_alternative) { build(:alternative) }

      it 'returns true' do
        expect(question.multiple?).to be(true)
      end
    end

    context 'when there are no correct alternatives' do
      subject { build(:question_with_no_correct_alternatives) }

      before { subject.valid? }

      it 'returns false' do
        expect(subject.multiple?).to be(false)
      end

      it 'returns an error message' do
        expect(subject.errors[:base]).to include('Must have alternatives')
      end
    end
  end
end
