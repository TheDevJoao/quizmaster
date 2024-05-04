# frozen_string_literal: true

class CreateQuestionAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :question_answers do |t|
      t.references :quiz_answer, null: false, index: true, foreign_key: true
      t.references :quiz_question, null: false, index: true, foreign_key: true
      t.references :alternative, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
