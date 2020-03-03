class Show < ApplicationRecord
  GENRES = [
    "Cabaret and Variety",
    "Children's Shows",
    "Comedy"
    # TODO: finish the list
  ]
  belongs_to :venue
  has_many :shortlists
  has_many :performances
  validates :url, uniqueness: true

 include PgSearch::Model
     pg_search_scope :search,
       against: [ :title, :description ],
       using: {
         tsearch: { prefix: true }
       }
end

