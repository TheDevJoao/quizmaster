class CreateQuizSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :quiz_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.jsonb :answers, default: []
      t.jsonb :quiz_snapshot, default: {}
      t.jsonb :result, default: {}

      t.timestamps
    end
  end
end
