# frozen_string_literal: true

class CreateUser < SeedMigration::Migration
  def up
    User.create! email: Faker::Internet.email, password: '123456'
  end

  def down; end
end
