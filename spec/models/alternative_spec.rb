# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Alternative, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:question) }
    it { is_expected.to have_many(:question_answers).dependent(:restrict_with_error) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:statement) }
  end
end
