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

  def colour_class
    classes = {
      "Comedy" => "card-border-comedy",
      "Cabaret and Variety" => "card-border-cabaret-variety",
      "Dance, PhysicalTheatre and Circus" => "card-border-circus-etc",
      "Theatre" => "card-border-theatre-etc",
      "Musicals and Opera" => "card-border-theatre-etc",
      "Events" => "card-border-events-etc",
      "Exhibitions" => "card-border-events-etc",
      "Children's Shows" => "card-border-other",
      "Spoken Word" => "card-border-other",
      "Music" => "card-border-other"
    }
    classes[self.genre]
  end

  def dates_between(start_date, end_date)
    @valid_shows
    self.each do |show|
      show.p
    end
  end
end

