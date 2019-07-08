# frozen_string_literal: true

require 'rails_helper'

RSpec.feature Task, type: :feature do
  let(:task) do
    FactoryBot.create(:task)
  end
  let(:project) do
    FactoryBot.create(:project)
  end

  before do
    login_as(FactoryBot.create(:user), scope: :user)
  end

  scenario 'Create a new Task' do
    visit new_task_path
    within find('#form_task') do
      fill_in Task.human_attribute_name(:name), with: Faker::Lorem.paragraph(4)
      fill_in Task.human_attribute_name(:description), with: Faker::Lorem.paragraph(4)
      click_button I18n.t('helpers.submit.create')
    end
  end

  scenario 'Show Task' do
    visit task_path(id: task.to_param)
  end

  scenario 'Edit Task' do
    visit edit_task_path(id: task.to_param)
    within find('#form_task') do
      fill_in Task.human_attribute_name(:name), with: Faker::Lorem.paragraph(4)
      fill_in Task.human_attribute_name(:description), with: Faker::Lorem.paragraph(4)
      select I18n.t('activerecord.attributes.task.statuses.review'), from: Task.human_attribute_name(:status)
      click_button I18n.t('helpers.submit.update')
    end
  end
end
