class Comment < ActiveRecord::Base
  belongs_to :micropost

  validates_presence_of :commenter, :body, :micropost_id
end
