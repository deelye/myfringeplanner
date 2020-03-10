class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :shortlists
  has_many :planners
  has_many :shows, through: :shortlists
  has_many :performances, through: :shows
  has_many :planned_performances, through: :planners, source: :performance
  has_one_attached :photo
  acts_as_follower
  # validates :photo, presence: true
end
