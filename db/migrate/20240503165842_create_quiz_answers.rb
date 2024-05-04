# frozen_string_literal: true

class CreateQuizAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :quiz_answers do |t|
      t.references :user, null: false, index: true, foreign_key: true
      t.references :quiz, null: false, index: true, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
