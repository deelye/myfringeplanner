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
      "Comedy" => "comedy-shadow",
      "Cabaret and Variety" => "cabaret-variety-shadow",
      "Dance, PhysicalTheatre and Circus" => "circus-etc-shadow",
      "Theatre" => "theatre-etc-shadow",
      "Musicals and Opera" => "theatre-etc-shadow",
      "Events" => "events-etc-shadow",
      "Exhibitions" => "events-etc-shadow",
      "Children's Shows" => "other-shadow",
      "Spoken Word" => "other-shadow",
      "Music" => "other-shadow"
    }
    classes[self.genre]
  end

  def dates_between(start_date, end_date)
    @valid_shows
    self.each do |show|
      show.p
    end
  end

  def times
    @starts = self.performances.map { |performance| performance.start.strftime("%R") }.uniq
    @ends = self.performances.map { |performance| performance.end.strftime("%R") }.uniq

    @times = []
    @starts.each_with_index do |start, index|
      @times << @starts[index] + " - " + @ends[index]
    end

    @times.join(", ")
  end
end

