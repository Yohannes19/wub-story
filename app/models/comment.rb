class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :story

  has_many :CommentLikes, dependent: :destroy

  validates :content, presence: true
end
