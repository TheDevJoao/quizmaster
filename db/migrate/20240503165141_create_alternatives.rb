# frozen_string_literal: true

class CreateAlternatives < ActiveRecord::Migration[7.1]
  def change
    create_table :alternatives do |t|
      t.references :question, null: false, index: true, foreign_key: true
      t.string :statement, null: false
      t.string :description
      t.boolean :correct, null: false, default: false

      t.timestamps
    end
  end
end
