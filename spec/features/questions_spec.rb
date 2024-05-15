# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "Questions", :js do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  before { sign_in user }

  describe 'index' do
    subject { visit questions_path }

    context 'when questions exist' do
      let!(:questions) { create_list(:question, 3) }

      before { subject }

      it 'displays the questions' do
        within('div#questions') do
          expect(page).to have_content(questions.last.statement)
          expect(page).to have_content(questions.last.description)
        end
      end

      it 'renders the expected amount of questions' do
        expect(Question.count).to eq(3)
      end
    end

    context 'when questions do not exist' do
      before do
        Question.destroy_all
        subject
      end

      it 'does not display any questions' do
        within('div#questions') do
          expect(page).to have_no_css('*')
        end
      end

      it 'renders zero questions' do
        expect(Question.count).to eq(0)
      end
    end
  end

  describe 'new' do
    it 'displays the new question form' do
      visit new_question_path
      expect(page).to have_selector('form')
    end
  end

  describe 'create' do
    subject do
      visit new_question_path
      fill_in 'Statement', with: statement
      fill_in 'Description', with: description
      click_button 'Create Question'
    end

    context 'when parameters are valid' do
      let(:statement) { 'a question statement' }
      let(:description) { 'a question description' }

      before do
        subject
        click_link 'Add alternative'
        within('.nested-fields') do
          fill_in 'Statement', with: 'an alternative statement'
          fill_in 'Description', with: 'an alternative description'
          check 'Correct'
        end
        click_button 'Create Question'
      end

      it 'creates a new question and redirects to index' do
        expect(page).to have_current_path(questions_path)
        expect(page).to have_content(statement)
      end
    end

    context 'when parameters are invalid' do
      let(:statement) { '' }
      let(:description) { '' }

      before { subject }

      context 'and the add alternatives link is not clicked' do
        it 'displays validation errors' do
          expect(page).to have_content("Statement can't be blank")
          expect(page).to have_content('Must have alternatives')
        end
      end

      context 'and the add alternatives link is clicked' do
        before do
          visit new_question_path
          click_link 'Add alternative'

          within('.nested-fields') do
            fill_in 'Statement', with: ''
            fill_in 'Description', with: ''
          end
          click_button 'Create Question'
        end
        it 'displays validation errors' do
          expect(page).to have_content("Alternatives statement can't be blank")
        end
      end
    end
  end

  describe 'destroy' do
    context 'when a question exists' do
      let!(:question) { create(:question) }

      before do
        visit questions_path
        find('a[data-turbo-method="delete"][href="/questions/1"]').click
      end

      it 'deletes a question' do
        expect(page).to have_content('Question was successfully destroyed.')
      end
    end

    context 'when a question does not exist' do
      before do
        visit questions_path
        Question.destroy_all
      end

      it 'does not render a delete link' do
        expect(page).to have_no_css('a[data-turbo-method="delete"][href="/questions/1"]')
      end
    end
  end
end
