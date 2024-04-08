class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :identifier
      t.string :statement
      t.string :description
      t.jsonb :config, default: {}

      t.timestamps
    end
  end
end
