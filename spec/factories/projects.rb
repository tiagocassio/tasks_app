# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :project do
    name { Faker::App.unique.name }
    description { Faker::Lorem.paragraph 4 }
    slug { SecureRandom.uuid.delete('-') }
  end
end
