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

class Task < ApplicationRecord
  include AASM

  include Sluggable

  belongs_to :project, optional: true

  enum status: %i[waiting review completed]

  validates :name, :description, :status, presence: true

  ransacker :id_to_s do
    Arel.sql("regexp_replace(to_char(\"#{table_name}\".\"id\", '9999999'), ' ', '', 'g')")
  end

  scope :review_tasks, -> {where(status: :review)}
  scope :waiting_tasks, -> {where(status: :waiting)}
  scope :completed_tasks, -> {where(status: :completed)}

  # Search by id, name, description or project name
  ransack_alias :search, :id_to_s_or_name_or_description_or_project_name

  # Using AASM to manage status transition
  aasm column: 'status', logger: Rails.logger do
    after_all_transitions :log_status

    state :waiting, initial: true
    state :review, :completed

    event :wait do
      transitions from: :waiting, to: :review
    end

    event :complete do
      transitions from: :review, to: :completed, guard: false
    end

    event :cancel do
      transitions from: :completed, to: :waiting
      transitions from: %i[waiting completed], to: :review
    end
  end

  def change_status(status)
    update(status: status.to_sym)
  end
end
