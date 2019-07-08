# frozen_string_literal: true

class CreateTasks < SeedMigration::Migration
  def up
    20.times do
      Task.create! name: "Task ##{Faker::Number.positive(0, 1_000_000)}", description: Faker::ChuckNorris.fact
    end
  end

  def down; end
end
