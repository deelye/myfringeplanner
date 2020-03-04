class Show < ApplicationRecord
  GENRES = [
    "Cabaret and Variety",
    "Children's Shows",
    "Comedy",
    "Dance, Physical Theatre and Circus",
    "Events",
    "Exhibitions",
    "Music",
    "Musicals and Opera",
    "Spoken Word",
    "Theatre"
    # TODO: finish the list
  ]
  belongs_to :venue
  has_many :shortlists
  has_many :performances
  validates :url, uniqueness: true

  acts_as_followable

 include PgSearch::Model
     pg_search_scope :search,
       against: [ :title, :description ],
       using: {
         tsearch: { prefix: true }
       }
end

