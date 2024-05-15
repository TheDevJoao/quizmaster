# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "QuizAnswers", :js do
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'new' do
    let(:quiz) { create(:quiz) }

    before { visit "/quizzes/#{quiz.id}/quiz_answers/new" }

    it 'displays the new quiz answer form' do
      expect(page).to have_selector('form')
    end

    it 'displays the quiz title' do
      expect(page).to have_content(quiz.title)
    end

    it 'displays the questions' do
      quiz.quiz_questions.each do |quiz_question|
        expect(page).to have_content(quiz_question.question.statement)
      end
    end

    it 'renders the expected amount of quiz questions' do
      expect(QuizQuestion.count).to eq(3)
    end

    it 'renders the expected amount of alternatives' do
      expect(Alternative.count).to eq(7)
    end

    it 'renders the create quiz answer button' do
      expect(page).to have_button('Create Quiz answer')
    end
  end

  describe 'create' do
    let(:quiz) { create(:quiz) }

    before do
      quiz.quiz_questions.last.destroy
      visit "/quizzes/#{quiz.id}/quiz_answers/new"
    end

    context 'when all alternatives have been marked' do
      it 'creates a quiz answer' do
        all('li').each do |li|
          within(li) do
            first("input[type=radio]").click
          end
        end

        click_button 'Create Quiz answer'

        expect(page).to have_content('Quiz was successfully answered.')
      end
    end

    context 'when not all alternatives have been marked' do
      it 'does not create a quiz answer' do
        click_button 'Create Quiz answer'

        expect(page).to have_content('error prohibited this quiz from being saved')
        expect(page).to have_content('Question answers alternative must exist')
      end
    end

    context 'when multiple answers alternatives exist' do
      let(:quiz) { create(:quiz) }

      it 'creates a quiz answer' do
        all("input[type=radio]").each do |checkbox|
          checkbox.click
        end

        click_button 'Create Quiz answer'

        expect(page).to have_content('Quiz was successfully answered.')
      end
    end
  end
end
