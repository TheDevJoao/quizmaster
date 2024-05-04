# frozen_string_literal: true

class CreateQuizQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :quiz_questions do |t|
      t.references :question, null: false, index: true, foreign_key: true
      t.references :quiz, null: false, index: true, foreign_key: true
      t.integer :position, null: false
      t.integer :weight, null: false

      t.timestamps
    end
  end
end
