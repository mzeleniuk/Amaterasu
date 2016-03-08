require 'rails_helper'
include SessionsHelper

RSpec.describe AdminController, type: :controller do
  describe 'GET #index' do
    let(:admin_user) { create :user, :admin }
    let(:user) { create :user }

    context 'when admin user is logged in' do
      before { sign_in(admin_user) }

      it 'returns http success' do
        get :index

        expect(response).to have_http_status(:success)
      end

      it 'renders the index template' do
        get :index

        expect(response).to render_template(:index)
      end
    end

    it 'redirects to root page if user is not admin' do
      sign_in(user)
      get :index

      expect(response).to redirect_to(root_path)
    end

    it 'redirects to login page if user is not logged in' do
      get :index

      expect(response).to redirect_to(signin_path)
    end
  end
end
