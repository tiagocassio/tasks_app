# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :status
      t.belongs_to :project, foreign_key: true, index: true
      t.string :slug

      t.timestamps
    end
  end
end
