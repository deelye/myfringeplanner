class Show < ApplicationRecord
  belongs_to :venue
  has_many :planners
  has_many :shortlists
  validates :url, uniqueness: true
end
