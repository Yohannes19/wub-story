class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_validation :set_default_role, on: :create
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  enum role: { listener: 0, narrator: 1, admin: 2 }
  has_many :stories, dependent: :destroy
  has_one_attached :avatar
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_follows, source: :followed

  has_many :passive_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower

  has_one_attached :profile_image

  validates :role, presence: true

  def following?(other_user)
    following.include?(other_user)
  end
  
  def follow(other_user)
    following << other_user unless self == other_user
  end
  
  def unfollow(other_user)
    active_follows.find_by(followed_id: other_user.id)&.destroy
  end

  # In User model
def profile_image_or_default
  profile_image.presence || 'logo1.png'
end

  

  def set_default_role
    self.role = "listener" if role.blank?
  end

  
end
