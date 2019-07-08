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

require 'rails_helper'

RSpec.describe Project, type: :model do
  subject(:project) do
    FactoryBot.create(:project)
  end

  it {should validate_presence_of :name}
  it {should validate_presence_of :description}
  it {should have_many :tasks}

  it 'is invalid without name' do
    project.name = nil
    expect(project).to_not be_valid
  end

  it 'is invalid without description' do
    project.description = nil
    expect(project).to_not be_valid
  end

  it 'is valid attributes' do
    expect(project).to be_valid
  end

  it 'has zero tasks' do
    expect(project.tasks.count).to eq 0
  end

  it 'has one task' do
    project.tasks << FactoryBot.create(:task)
    expect(project.tasks.count).to eq 1
  end

  it 'has task with [review] status' do
    project.tasks << FactoryBot.create(:task, status: Task.statuses[:review])
    expect(project.tasks.map {|t| t.status == Task.statuses[:review]}).to be_truthy
  end

  it 'has task with [waiting] status' do
    project.tasks << FactoryBot.create(:task, status: Task.statuses[:waiting])
    expect(project.tasks.map {|t| t.status == Task.statuses[:waiting]}).to be_truthy
  end

  it 'has task with [completed] status' do
    project.tasks << FactoryBot.create(:task, status: Task.statuses[:completed])
    expect(project.tasks.map {|t| t.status == Task.statuses[:completed]}).to be_truthy
  end
end
