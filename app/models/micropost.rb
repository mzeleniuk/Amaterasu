class Micropost < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader

  validates :content, presence: true
  validates :user_id, presence: true
  validate :picture_size

  private

  def picture_size
    if picture.size > 2.megabytes
      errors.add(:picture, 'should be less than 2 MB')
    end
  end
end
