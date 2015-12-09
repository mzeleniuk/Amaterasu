class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :micropost

  validates_presence_of :user_id, :micropost_id
  validates :body, presence: true, length: {maximum: 500}
end
