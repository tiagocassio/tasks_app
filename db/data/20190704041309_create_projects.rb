# frozen_string_literal: true

class CreateProjects < SeedMigration::Migration
  def up
    10.times do
      Project.create! name: Faker::App.name,
                      description: Faker::Lorem.characters(255)
    end
  end

  def down; end
end
