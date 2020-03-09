class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :shortlists
  has_many :planners
  has_many :performances, through: :shows
  has_many :planned_performances, through: :planners, source: :performance
  has_many :booked_shows, through: :planned_performances, source: :show

  acts_as_follower

  def shows
    follows.map{|f| f.followable}
  end

  def shortlist_events
    a = shows - booked_shows
    a.map{|r| r.performances}.flatten
  end
end
