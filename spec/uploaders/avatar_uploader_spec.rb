require 'rails_helper'
require 'carrierwave/test/matchers'

describe AvatarUploader do
  include CarrierWave::Test::Matchers

  describe 'Avatar uploader' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      AvatarUploader.enable_processing = true
      @uploader = AvatarUploader.new(user, :avatar)

      File.open('app/assets/images/rails.png') do |f|
        @uploader.store!(f)
      end
    end

    after do
      AvatarUploader.enable_processing = false
      @uploader.remove!
    end

    context '.default_url' do
      it 'have right default_url' do
        expect(@uploader.default_url).to eq('user_avatar.png')
      end
    end

    context '.store_dir' do
      it 'have right store_dir' do
        expect(@uploader.store_dir).to eq("uploads/#{user.class.to_s.underscore}/avatar/#{user.id}")
      end
    end
  end
end
