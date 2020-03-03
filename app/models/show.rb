class Show < ApplicationRecord
  belongs_to :venue
  has_many :shortlists
  validates :url, uniqueness: true

 include PgSearch::Model
     pg_search_scope :global_search,
       against: [ :artist, :title, :description, :genre ],
       using: {
         tsearch: { prefix: true }
       }
end

