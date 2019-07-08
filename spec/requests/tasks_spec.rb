# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  # Add Devise session configuration
  let(:user) do
    FactoryBot.create(:user)
  end

  let(:task) do
    FactoryBot.create(:task)
  end

  context 'with authenticated user' do
    before do
      login_as user, scope: :user
    end
    describe 'make GET request to /tasks' do
      it 'return success response' do
        get tasks_path
        expect(response).to have_http_status(200)
      end
    end

    describe 'make GET request to /tasks/new' do
      it 'return success response' do
        get new_task_path
        expect(response).to have_http_status(200)
      end
    end

    describe 'make GET request to /tasks/{id}' do
      it 'return success response' do
        get task_path(id: task.to_param)
        expect(response).to have_http_status(200)
      end
    end

    describe 'make GET request to /tasks/{id}/edit' do
      it 'return success response' do
        get edit_task_path(id: task.to_param)
        expect(response).to have_http_status(200)
      end
    end

    describe 'make DELETE request to /tasks/{id}/delete' do
      it 'return success response' do
        delete task_path(id: task.to_param)
        expect(response).to redirect_to(tasks_path)
      end
    end
  end

  context 'without authenticated user' do
    let(:fail_response) do
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(new_user_session_url)
    end
    describe 'make GET request to /tasks' do
      it 'return fail response' do
        get tasks_path
        fail_response
      end
    end

    describe 'make GET request to /tasks/new' do
      it 'return success response' do
        get new_task_path
        fail_response
      end
    end

    describe 'make GET request to /tasks/{id}' do
      it 'return success response' do
        get task_path(id: task.to_param)
        fail_response
      end
    end

    describe 'make GET request to /tasks/{id}/edit' do
      it 'return success response' do
        get edit_task_path(id: task.to_param)
        fail_response
      end
    end

    describe 'make DELETE request to /tasks/{id}/delete' do
      it 'return success response' do
        delete task_path(id: task.to_param)
        fail_response
      end
    end
  end
end
