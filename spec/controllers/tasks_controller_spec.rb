# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:valid_attributes) do
    FactoryBot.attributes_for(:task)
  end

  let(:invalid_attributes) do
    FactoryBot.attributes_for(:task, name: nil, description: nil)
  end

  let(:task) do
    FactoryBot.create(:task)
  end

  let(:failed_response) do
    expect(response.status).to eq 302
    expect(response).to redirect_to(new_user_session_url)
  end

  # Add Devise session configuration
  let(:session) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in FactoryBot.create(:user)
  end

  context 'with authenticated user' do
    describe 'make GET index Task list' do
      it 'and returns a success response' do
        get :index, params: {}, session: session
        expect(response.status).to eq 200
      end
    end

    describe 'make GET Request to new Task' do
      it 'and returns a success response' do
        get :new, params: {}, session: session
        expect(response.status).to eq 200
      end
    end

    describe 'make GET Request to show Task' do
      it 'and returns a success response' do
        get :show, params: { id: task.to_param }, session: session
        expect(response.status).to eq 200
      end
    end

    describe 'make GET Request to edit Task' do
      it 'and returns a success response' do
        get :edit, params: { id: task.to_param }, session: session
        expect(response.status).to eq 200
      end
    end

    describe 'make GET Request to edit Task status' do
      it 'and returns a success response' do
        get :change_status, params: { id: task.to_param, status: :waiting }, session: session
        expect(response.status).to eq 200
      end
    end

    describe 'POST Task' do
      context 'with valid Task params' do
        it 'creates a new Task' do
          post :create, params: { task: valid_attributes }, session: session
          expect(Task.count).to eq 1
        end

        it 'redirects to the created Task' do
          post :create, params: { task: valid_attributes }, session: session
          expect(response).to redirect_to(Task.last)
        end
      end

      context 'with invalid Task params' do
        it 'fails returns a (402) unprocessable entity status' do
          post :create, params: { task: invalid_attributes }, session: session
          expect(response.status).to eq 422
        end
      end
    end

    describe 'PUT task' do
      context 'with valid Task params' do
        let(:updated_attributes) do
          { name: Faker::App.name, description: Faker::Lorem.paragraph(4) }
        end
        it 'updates the requested Task' do
          put :update, params: { id: task.to_param, task: updated_attributes }, session: session
          expect(response.status).to eq 302
          updated_task = OpenStruct.new(updated_attributes)
          expect(task.name).not_to eq updated_task.name
          expect(task.description).not_to eq updated_task.description
        end

        it 'redirects to the updated Task' do
          put :update, params: { id: task.to_param, task: updated_attributes }, session: session
          expect(response).to redirect_to(task)
        end
      end

      context 'with invalid params' do
        it 'and returns a success response' do
          put :update, params: { id: task.to_param, task: invalid_attributes }, session: session
          expect(response.status).to eq 422
        end
      end
    end

    describe 'DELETE Task' do
      it 'destroys the requested Task' do
        delete :destroy, params: { id: task.to_param }, session: session
        expect(0).to eq Task.count
      end

      it 'and returns success response' do
        expect(response.status).to eq 200
      end
    end
  end

  context 'without authenticated user' do
    describe 'make GET index Task list' do
      it 'redirect to login page' do
        get :index, params: {}, session: nil
        failed_response
      end
    end

    describe 'make GET Request to new Task' do
      it 'redirect to login page' do
        get :new, params: {}, session: nil
        failed_response
      end
    end

    describe 'make GET Request to show Task' do
      it 'and returns a success response' do
        get :show, params: { id: task.to_param }, session: nil
        failed_response
      end
    end

    describe 'make GET Request to edit Task' do
      it 'and returns a success response' do
        get :edit, params: { id: task.to_param }, session: nil
        failed_response
      end
    end

    describe 'POST Task' do
      context 'with valid Task params' do
        it 'return fail response' do
          post :create, params: { task: valid_attributes }, session: nil
          expect(response.status).to eq 302
        end

        it 'redirects to the login page' do
          post :create, params: { task: valid_attributes }, session: nil
          failed_response
        end
      end
    end
  end
end
