# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:valid_attributes) do
    FactoryBot.attributes_for(:project)
  end

  let(:invalid_attributes) do
    FactoryBot.attributes_for(:project, name: nil, description: nil)
  end

  let(:failed_response) do
    expect(response.status).to eq 302
    expect(response).to redirect_to(new_user_session_url)
  end

  let(:project) do
    FactoryBot.create(:project)
  end

  # Add Devise session configuration
  let(:session) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in FactoryBot.create(:user)
  end

  context 'with authenticated user' do
    describe 'make GET index Project list' do
      it 'and returns a success response' do
        get :index, params: {}, session: session
        expect(response.status).to eq 200
      end
    end

    describe 'make GET Request to new Project' do
      it 'and returns a success response' do
        get :new, params: {}, session: session
        expect(response.status).to eq 200
      end
    end

    describe 'make GET Request to show Project' do
      it 'and returns a success response' do
        get :show, params: { id: project.to_param }, session: session
        expect(response.status).to eq 200
      end
    end

    describe 'make GET Request to edit Project' do
      it 'and returns a success response' do
        get :edit, params: { id: project.to_param }, session: session
        expect(response.status).to eq 200
      end
    end

    describe 'POST Project' do
      context 'with valid Project params' do
        it 'creates a new Project' do
          post :create, params: { project: valid_attributes }, session: session
          expect(Project.count).to eq 1
        end

        it 'redirects to the created project' do
          post :create, params: { project: valid_attributes }, session: session
          expect(response).to redirect_to(Project.last)
        end
      end

      context 'with invalid Project params' do
        it 'fails returns a (402) unprocessable entity status' do
          post :create, params: { project: invalid_attributes }, session: session
          expect(response.status).to eq 422
        end
      end
    end

    describe 'PUT project' do
      context 'with valid Project params' do
        let(:updated_attributes) do
          { name: Faker::App.name, description: Faker::Lorem.paragraph(4) }
        end
        it 'updates the requested Project' do
          put :update, params: { id: project.to_param, project: updated_attributes }, session: session
          expect(response.status).to eq 302
          updated_project = OpenStruct.new(updated_attributes)
          expect(project.name).not_to eq updated_project.name
          expect(project.description).not_to eq updated_project.description
        end

        it 'redirects to the updated Project' do
          put :update, params: { id: project.to_param, project: updated_attributes }, session: session
          expect(response).to redirect_to(project)
        end
      end

      context 'with invalid params' do
        it 'and returns a success response' do
          put :update, params: { id: project.to_param, project: invalid_attributes }, session: session
          expect(response.status).to eq 422
        end
      end
    end

    describe 'DELETE Project' do
      it 'destroys the requested Project' do
        delete :destroy, params: { id: project.to_param }, session: session
        expect(0).to eq Project.count
      end

      it 'and returns success response' do
        expect(response.status).to eq 200
      end
    end
  end

  context 'without authenticated user' do
    describe 'make GET index Project list' do
      it 'redirect to login page' do
        get :index, params: {}, session: nil
        failed_response
      end
    end

    describe 'make GET Request to new Project' do
      it 'redirect to login page' do
        get :new, params: {}, session: nil
        failed_response
      end
    end

    describe 'make GET Request to show Project' do
      it 'redirect to login page' do
        get :show, params: { id: project.to_param }, session: nil
        failed_response
      end
    end

    describe 'make GET Request to edit Project' do
      it 'redirect to login page' do
        get :edit, params: { id: project.to_param }, session: nil
        failed_response
      end
    end

    describe 'POST Project' do
      context 'with valid Project params' do
        it 'return failed response' do
          post :create, params: { project: valid_attributes }, session: nil
          expect(response.status).to eq 302
        end

        it 'redirects to the login page' do
          post :create, params: { project: valid_attributes }, session: nil
          failed_response
        end
      end
    end
  end
end
