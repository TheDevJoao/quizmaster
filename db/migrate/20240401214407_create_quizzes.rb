class CreateQuizzes < ActiveRecord::Migration[7.1]
  def change
    create_table :quizzes do |t|
      t.string :identifier
      t.string :title
      t.string :description
      t.jsonb :config, default: {}
      t.string :result_calculator

      t.timestamps
    end
  end
end
