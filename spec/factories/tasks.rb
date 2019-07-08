# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  slug        :string
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :bigint
#
# Indexes
#
#  index_tasks_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#

FactoryBot.define do
  factory :task do
    name { "##{Faker::Number.unique.number} - #{Faker::Lorem.paragraph}" }
    description { Faker::Lorem.paragraph 4 }
    status { %i[review waiting completed].to_a.sample }
    project
    slug { SecureRandom.uuid.delete('-') }
  end
end
