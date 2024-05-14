# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionAnswer, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:quiz_answer) }
    it { is_expected.to belong_to(:quiz_question) }
    it { is_expected.to belong_to(:alternative) }
  end
end
