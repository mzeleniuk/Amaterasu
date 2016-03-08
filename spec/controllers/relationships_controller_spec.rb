require 'rails_helper'
include SessionsHelper

describe RelationshipsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  describe 'when user is logged in' do
    before do
      sign_in(user)
    end

    context 'creating a relationship with Ajax' do
      it 'increments the Relationship count' do
        expect do
          xhr :post, :create, followed_id: other_user.id
        end.to change(Relationship, :count).by(1)
      end

      it 'responds with success' do
        xhr :post, :create, followed_id: other_user.id

        expect(response).to have_http_status(:success)
      end
    end

    context 'destroying a relationship with Ajax' do
      before { user.follow(other_user) }
      let(:relationship) { user.active_relationships.find_by(followed_id: other_user) }

      it 'decrements the Relationship count' do
        expect do
          xhr :delete, :destroy, id: relationship.id
        end.to change(Relationship, :count).by(-1)
      end

      it 'responds with success' do
        xhr :delete, :destroy, id: relationship.id

        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'when user is logged out' do
    context 'creating a relationship with Ajax' do
      it 'redirects to sign in page' do
        xhr :post, :create, followed_id: other_user.id

        expect(response).to redirect_to(signin_path)
      end
    end

    context 'destroying a relationship with Ajax' do
      before { user.follow(other_user) }
      let(:relationship) { user.active_relationships.find_by(followed_id: other_user) }

      it 'redirects to sign in page' do
        xhr :delete, :destroy, id: relationship.id

        expect(response).to redirect_to(signin_path)
      end
    end
  end
end
