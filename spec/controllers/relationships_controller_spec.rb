require 'rails_helper'
include SessionsHelper

describe RelationshipsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  before do
    sign_in(user)
  end

  describe 'creating a relationship with Ajax' do
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

  describe 'destroying a relationship with Ajax' do
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
