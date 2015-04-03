# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  include CarrierWave::MiniMagick
  process resize_to_limit: [60, 60]

  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

  if Rails.env.development?
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    'user_avatar.png'
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :standard do
    process :convert => 'png'
    cloudinary_transformation :quality => 80
  end

  version :thumbnail do
    resize_to_fit(50, 50)
  end
end
