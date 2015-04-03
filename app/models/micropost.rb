class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :content, presence: true
  validates :user_id, presence: true
  validate  :picture_size

  def self.from_users_followed_by(user)
    followed_user_ids = 'SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id'
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end

  private

  def picture_size
    if picture.size > 2.megabytes
      errors.add(:picture, 'should be less than 2 MB')
    end
  end
end
