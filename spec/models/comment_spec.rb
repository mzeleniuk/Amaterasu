require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'User ID' do
    it 'is not valid when user_id is blank' do
      comment = build :comment, user_id: ''

      expect(comment.valid?).to eq(false)
      expect(comment.errors[:user_id]).to eq(["can't be blank"])
    end

    it 'is valid when user_id is present' do
      comment = build :comment, user_id: 1

      expect(comment.valid?).to eq(true)
    end
  end

  context 'Body' do
    it 'is not valid when body is blank' do
      comment = build :comment, body: ''

      expect(comment.valid?).to eq(false)
      expect(comment.errors[:body]).to eq(["can't be blank"])
    end

    it 'is valid when body is present' do
      comment = build :comment, body: 'Some text.'

      expect(comment.valid?).to eq(true)
    end
  end

  context 'Micropost ID' do
    it 'is not valid when micropost_id is blank' do
      comment = build :comment, micropost_id: ''

      expect(comment.valid?).to eq(false)
      expect(comment.errors[:micropost_id]).to eq(["can't be blank"])
    end

    it 'is valid when micropost_id is present' do
      comment = build :comment, micropost_id: 1

      expect(comment.valid?).to eq(true)
    end
  end
end
