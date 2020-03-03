class Show < ApplicationRecord
  belongs_to :venue
  has_many :shortlists
  has_many :performances
  validates :url, uniqueness: true
end
