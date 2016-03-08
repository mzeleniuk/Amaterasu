require 'rails_helper'
include SessionsHelper

describe MicropostsController, type: :controller do
  describe 'POST #create' do
    let(:user) { create :user }
    let(:valid_micropost_params) do
      {
        micropost: {
          content: 'Test content.'
        }
      }
    end
    let(:invalid_micropost_params) do
      {
        micropost: {
          content: ''
        }
      }
    end

    context 'when the record save successfully' do
      before do
        sign_in(user)
      end

      it 'saves the micropost' do
        expect { post :create, valid_micropost_params }.to change(Micropost, :count).by(1)
      end

      it 'redirects to home page' do
        post :create, valid_micropost_params

        expect(response).to redirect_to(root_path)
      end
    end

    context 'when the record has not been saved' do
      before do
        sign_in(user)
      end

      it 'not saves the micropost' do
        expect { post :create, invalid_micropost_params }.to_not change(Micropost, :count)
      end

      it 'renders a new template' do
        post :create, invalid_micropost_params

        expect(response).to render_template('static_pages/home', 'layouts/application')
      end
    end

    context 'when user is not logged in' do
      it 'not creates a micropost' do
        expect { post :create, valid_micropost_params }.to_not change(Micropost, :count)
      end

      it 'redirects user to login page' do
        post :create, valid_micropost_params

        expect(response).to redirect_to(signin_path)
      end
    end
  end

  describe 'POST #destroy' do
    let(:user) { create :user }
    let(:second_user) { create :user }
    let(:micropost) { create :micropost, user: user }
    let(:second_micropost) { create :micropost, user: second_user }

    it 'redirects user when he is not logged in' do
      delete :destroy, id: micropost

      expect(response).to redirect_to(signin_path)
    end

    it 'redirects destroy for wrong micropost' do
      sign_in(second_user)

      expect { delete :destroy, id: second_micropost }.to_not change(Micropost, :count)
    end
  end
end
