# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  include Devise::Test::ControllerHelpers

  # Add Devise session configuration
  let(:session) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in FactoryBot.create(:user)
  end

  context 'with authenticated user' do
    describe 'make GET to Dashboard page' do
      it 'and returns success response' do
        get :index, session: session
        expect(response.status).to eq 200
      end
    end

    describe 'make GET to status API' do
      it 'and returns success response' do
        get :status, session: session
        expect(response.status).to eq 200
      end
    end
  end

  context 'without authenticated user' do
    describe 'make GET to Dashboard page' do
      it 'redirect to login page' do
        get :index, session: nil
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end
end
