# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "Quizzes", :js  do
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'index' do
    let!(:quizzes) { create_list(:quiz, 2) }

    before { visit '/quizzes/'}

    context 'when quizzes exist' do
      it 'displays the list of quizzes' do
        quizzes.each do |quiz|
          expect(page).to have_content(quiz.title)
          expect(page).to have_content(quiz.description)
        end
      end

      it 'displays a few action links' do
        expect(page).to have_link('Edit')
        expect(page).to have_link('Delete')
        expect(page).to have_link('Start')
      end

      it "displays a 'New quiz' link" do
        expect(page).to have_link('New quiz')
      end

      it 'renders the expected amount of quizzes' do
        expect(Quiz.count).to eq(2)
      end

      context 'and contains question answers' do
        # TO DO
        # it 'renders a quizzes scores' do
        #   expect(page).to have_content('My scores')
        # end
      end
    end

  end

  describe 'new' do
    before { visit '/quizzes/new'}

    it 'displays the new quiz form' do
      expect(page).to have_selector('form')
    end
  end

  describe 'create' do
    let!(:questions) { create_list(:question, 2)}
    before { visit '/quizzes/new'}

    context 'when creating a new quiz' do
      before do
        within('form') do
          fill_in 'Title', with: 'statement'
          fill_in 'Description', with: 'description'
        end
      end

      context 'and questions have been created' do
        let(:css_selector) { "select[name^='quiz[quiz_questions_attributes]'][name$='[question_id]']" }

        before { click_link 'Add question' }

        it 'adds a question to the quiz' do
          expect(page).to have_selector(css_selector)
          select_option(css_selector, questions.first.statement)
          fill_in 'Weight', with: 100
          fill_in 'Position', with: 1

          click_button 'Create Quiz'
          expect(page).to have_content('Quiz was successfully created.')
          expect(page).to have_current_path('/quizzes')
        end

        it 'deletes a question that was going to be added to the quiz' do
          click_link 'Delete'

          expect(page).to have_no_css('a[data-turbo-method="delete"]')
        end
      end

      context 'and no questions have been created' do
        it 'displays validation errors' do
          click_button 'Create Quiz'
          expect(page).to have_content('2 errors prohibited this quiz from being saved')
          expect(page).to have_content('Must have questions')
          expect(page).to have_content('Weight must be 100')
        end
      end
    end
  end

  describe 'update' do
    # TO DO
    # context 'when a quiz has answers' do
    #   let!(:quiz) { create(:quiz) }

    #   before { visit "/quizzes/#{quiz.id}/edit" }

    #   it "displays a 'Cannot edit a answered quiz' message" do
    #     expect(page).to have_current_path('/quizzes')
    #     expect(page).to have_content('Cannot edit a answered quiz.')
    #   end
    # end

    context 'when a quiz has no answers' do
      let(:quiz) { create(:quiz) }

      before { visit "/quizzes/#{quiz.id}/edit" }

      it 'displays the edit quiz form' do
        expect(page).to have_selector('form')
        expect(page).to have_content('Editing quiz')
      end

      it 'displays the expected quiz data' do
        expect(page).to have_field('quiz_title', with: "#{quiz.title}")
        expect(page).to have_field('quiz_description', with: "#{quiz.description}")
      end

      it 'displays the expected quiz question data' do
        first_quiz_question = quiz.quiz_questions.first
        expect(page).to have_select('quiz_quiz_questions_attributes_0_question_id', selected: first_quiz_question.question.statement)
        expect(page).to have_field('quiz_quiz_questions_attributes_0_weight', with: first_quiz_question.weight)
        expect(page).to have_field('quiz_quiz_questions_attributes_0_position', with: first_quiz_question.position)
      end

      it 'deletes a quiz question from the quiz' do
        first_delete_link = page.find('a.remove_fields.existing', match: :first)

        first_delete_link.click

        expect(page).to have_css('a.remove_fields.existing', count: 2)

        fill_in 'quiz_quiz_questions_attributes_1_weight', with: 70
        click_button 'Update Quiz'
        expect(QuizQuestion.count).to eq(2)
        expect(page).to have_content('Quiz was successfully updated.')
      end
    end
  end

  #TO DO
  describe 'destroy' do

  end
end
