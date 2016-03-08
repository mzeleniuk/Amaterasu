require 'rails_helper'
include SessionsHelper

describe CommentsController, type: :controller do
  describe 'POST #create' do
    let(:user) { create :user }
    let(:micropost) { create :micropost }
    let(:valid_comment_params) do
      {
        comment: {body: 'Test comment.'},
        micropost_id: micropost.id
      }
    end
    let(:invalid_comment_params) do
      {
        comment: {body: ''},
        micropost_id: micropost.id
      }
    end

    context 'when the record saved successfully' do
      before do
        sign_in(user)
      end

      it 'saves the comment' do
        expect { post :create, valid_comment_params }.to change(Comment, :count).by(1)
      end

      it 'redirects to micropost page' do
        post :create, valid_comment_params

        expect(response).to redirect_to("http://test.host/en/users/#{micropost.user_id}")
      end
    end

    context 'when the record has not been saved' do
      before do
        sign_in(user)
      end

      it 'not saves the comment' do
        expect { post :create, invalid_comment_params }.to_not change(Comment, :count)
      end

      it 'receives JS responce' do
        xhr :get, 'create', invalid_comment_params

        expect(response.content_type).to eq(Mime::JS)
      end
    end

    context 'when user is not logged in' do
      it 'not creates a comment' do
        expect { post :create, valid_comment_params }.to_not change(Comment, :count)
      end

      it 'redirects user to login page' do
        post :create, valid_comment_params

        expect(response).to redirect_to(signin_path)
      end
    end
  end

  describe 'POST #destroy' do
    let(:user) { create :user }
    let(:second_user) { create :user }
    let(:micropost) { create :micropost, user: user }
    let(:comment) { create :comment, user: user, micropost: micropost }
    let(:second_comment) { create :comment, user: second_user, micropost: micropost }

    it 'redirects user when he is not logged in' do
      delete :destroy, micropost_id: micropost.id, id: comment.id

      expect(response).to redirect_to(signin_path)
    end

    it 'redirects destroy for wrong comment' do
      sign_in(second_user)

      expect { delete :destroy, micropost_id: micropost.id, id: second_comment.id }.to_not change(Comment, :count)
    end
  end
end
