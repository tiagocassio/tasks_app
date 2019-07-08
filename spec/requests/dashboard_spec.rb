require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do

  # Add Devise session configuration
  let(:user) do
    FactoryBot.create(:user)
  end

  context 'with authenticated user' do
    before do
      login_as user, scope: :user
    end

    describe 'make GET to Dashboard page' do
      it 'and returns success response' do
        get root_path
        expect(response).to have_http_status 200
      end
    end

    describe 'make GET to status endpoint' do
      it 'and returns success response' do
        get dashboard_status_path
        expect(response).to have_http_status 200
      end
    end
  end

  context 'without authenticated user' do
    describe 'make GET to Dashboard page' do
      it 'redirect to login page' do
        get root_path
        expect(response).to have_http_status 302
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end
end
