require 'rails_helper'
include SessionsHelper

describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'assigns a new account as @account' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'returns a http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders a new template' do
      get :new
      expect(response).to render_template('users/new')
    end
  end

  describe 'GET #show' do
    let(:user) { create :user }

    before do
      sign_in(user)
    end

    it 'finds the user by id and assign as @user' do
      get :show, {id: user.id}
      expect(assigns(:user)).to eq(user)
    end

    it 'returns a http success' do
      get :show, {id: user.id}
      expect(response).to have_http_status(:success)
    end

    it 'renders a show template' do
      get :show, {id: user.id}
      expect(response).to render_template('users/show')
    end
  end

  describe 'GET #index' do
    let(:user) { create :user }

    before do
      sign_in(user)
    end

    it 'responds successfully' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'loads all of the users into @user' do
      get :index
      expect(assigns(:users)).to match([user])
    end
  end

  describe 'POST #create' do
    let(:user_params) do
      {
        user: {
          name: 'Test User',
          email: 'test_user@mail.com',
          password: 'secret',
          password_confirmation: 'secret',
        }
      }
    end

    it 'builds and assigns as @user' do
      post :create, user_params
      expect(assigns(:user)).to be_a(User)
    end

    describe 'when the record save successfully' do
      before { allow_any_instance_of(User).to receive(:valid?).and_return(true) }

      it 'should save the user' do
        post :create, user_params
        expect(assigns(:user)).to be_persisted
      end

      it 'redirects to confirmation sent account' do
        post :create, user_params
        expect(response).to redirect_to(root_url)
      end
    end

    describe 'when the record has not been saved' do
      before { allow_any_instance_of(User).to receive(:valid?).and_return(false) }

      it 'not saves the user' do
        post :create, user_params
        expect(assigns(:user)).not_to be_persisted
      end

      it 'renders a new template' do
        post :create, user_params
        expect(response).to render_template('users/new')
      end
    end
  end
end
