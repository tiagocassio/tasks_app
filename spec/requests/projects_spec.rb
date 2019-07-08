# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  # Add Devise session configuration
  let(:user) do
    FactoryBot.create(:user)
  end

  let(:project) do
    FactoryBot.create(:project)
  end

  context 'with authenticated user' do
    before do
      login_as user, scope: :user
    end
    describe 'make GET request to /projects' do
      it 'return success response' do
        get projects_path
        expect(response).to have_http_status(200)
      end
    end

    describe 'make GET request to /projects/new' do
      it 'return success response' do
        get new_project_path
        expect(response).to have_http_status(200)
      end
    end

    describe 'make GET request to /projects/{id}' do
      it 'return success response' do
        get project_path(id: project.to_param)
        expect(response).to have_http_status(200)
      end
    end

    describe 'make GET request to /projects/{id}/edit' do
      it 'return success response' do
        get edit_project_path(id: project.to_param)
        expect(response).to have_http_status(200)
      end
    end

    describe 'make DELETE request to /projects/{id}/delete' do
      it 'return success response' do
        delete project_path(project.to_param), params: {id: project.to_param}
        expect(response).to have_http_status(302)
      end
    end
  end

  context 'without authenticated user' do
    let(:fail_response) do
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(new_user_session_url)
    end
    describe 'make GET request to /projects' do
      it 'return fail response' do
        get projects_path
        fail_response
      end
    end

    describe 'make GET request to /projects/new' do
      it 'return success response' do
        get new_project_path
        fail_response
      end
    end

    describe 'make GET request to /projects/{id}' do
      it 'return success response' do
        get project_path(id: project.to_param)
        fail_response
      end
    end

    describe 'make GET request to /projects/{id}/edit' do
      it 'return success response' do
        get edit_project_path(id: project.to_param)
        fail_response
      end
    end

    describe 'make DELETE request to /projects/{id}/delete' do
      it 'return success response' do
        delete project_path(id: project.to_param)
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end
end
