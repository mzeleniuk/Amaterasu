require 'rails_helper'
require 'carrierwave/test/matchers'

describe PictureUploader do
  include CarrierWave::Test::Matchers

  describe 'Picture uploader' do
    let(:user) { FactoryGirl.create(:user) }
    let(:micropost) { FactoryGirl.create(:micropost) }

    before do
      PictureUploader.enable_processing = true
      @uploader = PictureUploader.new(micropost, :picture)

      File.open('app/assets/images/rails.png') do |f|
        @uploader.store!(f)
      end
    end

    after do
      PictureUploader.enable_processing = false
      @uploader.remove!
    end

    context '.store_dir' do
      it 'have right store_dir' do
        expect(@uploader.store_dir).to eq("uploads/#{micropost.class.to_s.underscore}/picture/#{micropost.id}")
      end
    end
  end
end
