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

require 'rails_helper'

RSpec.describe Task, type: :model do
  subject(:task) do
    FactoryBot.create(:task)
  end

  it {should validate_presence_of :name}
  it {should validate_presence_of :description}
  it {should validate_presence_of :status}
  it {should_not belong_to :project}

  it 'has invalid name' do
    task.name = nil
    expect(task).to_not be_valid
  end

  it 'has invalid description' do
    task.description = nil
    expect(task).to_not be_valid
  end

  it 'has invalid description' do
    task.status = nil
    expect(task).to_not be_valid
  end

  it 'has valid attributes' do
    expect(task).to be_valid
  end

  it 'has a reference project' do
    task.project = FactoryBot.create(:project)
    expect(task.project).to_not be_nil
  end

  it "has [waiting] status" do
    task = FactoryBot.create(:task, status: Task.statuses[:waiting])
    expect(Task.statuses[task.status]).to eq Task.statuses[:waiting]
  end

  it "has [review] status" do
    task = FactoryBot.create(:task, status: Task.statuses[:review])
    expect(Task.statuses[task.status]).to eq Task.statuses[:review]
  end

  it "has [completed] status" do
    task = FactoryBot.create(:task, status: Task.statuses[:completed])
    expect(Task.statuses[task.status]).to eq Task.statuses[:completed]
  end

  it 'has initial state :review' do
    is_expected.to have_state :review
  end
end
