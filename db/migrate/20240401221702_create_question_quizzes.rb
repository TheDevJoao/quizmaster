class CreateQuestionQuizzes < ActiveRecord::Migration[7.1]
  def change
    create_table :question_quizzes do |t|
      t.references :question, null: false, foreign_key: true
      t.references :quiz, null: false, foreign_key: true
      t.integer :order
      t.jsonb :config, default: {}

      t.timestamps
    end
  end
end
