class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { listener: 0, narrator: 1 }
  has_many :stories, dependent: :destroy
  has_one_attached :avatar
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

end
