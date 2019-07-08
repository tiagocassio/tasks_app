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

# app/models/project.rb
class Project < ApplicationRecord
  include Sluggable

  has_many :tasks, dependent: :nullify

  validates :name, :description, presence: true

  ransacker :id_to_s do
    Arel.sql("regexp_replace(to_char(\"#{table_name}\".\"id\", '9999999'), ' ', '', 'g')")
  end

  # Search by id, name or description
  ransack_alias :search, :id_to_s_or_name_or_description

  def review_tasks
    tasks.map(&:completed?)
  end

  def waiting_tasks
    tasks.map(&:completed?)
  end

  def completed_tasks
    tasks.map(&:completed?)
  end
end
