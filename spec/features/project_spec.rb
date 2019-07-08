require 'rails_helper'

RSpec.feature Project, type: :feature do
  let(:project) do
    FactoryBot.create(:project)
  end

  before do
    login_as(FactoryBot.create(:user), scope: :user)
  end

  scenario 'Create a new Project' do
    visit new_project_path
    within find('#form_project') do
      fill_in Project.human_attribute_name(:name), with: Faker::Lorem.paragraph(4)
      fill_in Project.human_attribute_name(:description), with: Faker::Lorem.paragraph(4)
      click_button I18n.t('helpers.submit.create')
    end
  end

  scenario 'Show Project' do
    visit project_path(id: project.to_param)
  end

  scenario 'Edit Project' do
    visit edit_project_path(id: project.to_param)
    within find('#form_project') do
      fill_in Project.human_attribute_name(:name), with: Faker::Lorem.paragraph(4)
      fill_in Project.human_attribute_name(:description), with: Faker::Lorem.paragraph(4)
      click_button I18n.t('helpers.submit.update')
    end
  end
end