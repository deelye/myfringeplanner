class Show < ApplicationRecord
  belongs_to :venue
  has_many :shortlists
  validates :url, uniqueness: true
end
