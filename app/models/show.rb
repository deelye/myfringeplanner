class Show < ApplicationRecord
  GENRES = [
    "Cabaret and Variety",
    "Children's Shows",
    "Comedy",
    "Dance Physical Theatre and Circus",
    "Events",
    "Exhibitions",
    "Music",
    "Musicals and Opera",
    "Spoken Word",
    "Theatre"
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
      "Dance Physical Theatre and Circus" => "card-border-circus-etc",
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

  def times
    @starts = self.performances.map { |performance| performance.start.strftime("%R") }.uniq
    @ends = self.performances.map { |performance| performance.end.strftime("%R") }.uniq

    @times = []
    @starts.each_with_index do |start, index|
      @times << @starts[index] + " - " + @ends[index]
    end

    @times.join(", ")
  end

  def starts
    @starts = self.performances.map { |performance| performance.start.strftime("%R") }.uniq.join(", ")
  end

  def duration
    @diff = self.performances.first.end - self.performances.first.start
    Time.at(@diff.to_i.abs).utc.strftime "%kh %Mmin"

    h = Time.at(@diff.to_i.abs).utc.strftime "%k"
    m = Time.at(@diff.to_i.abs).utc.strftime "%M"

    if h == " 0"
      return "#{m}min"
    elsif m == "00"
      return "#{h.strip}h"
    else
      return "#{h.strip}h #{m}min"
    end
  end

  def dates
    dates = self.performances.map do |performance|
      if performance.start.to_datetime < performance.start.to_datetime.beginning_of_day + 0.25
      performance.start.day - 1
      else
        performance.start.day
      end
    end.uniq
  end

  def dates_string
    dates = self.dates
    condensed_dates = "Aug "
    dates.each_with_index do |date, index|
      if index == dates.count - 1
        condensed_dates += date.to_s
      elsif date != dates[index - 1] + 1 && date == dates[index + 1] - 1
        condensed_dates += date.to_s + '-'
      elsif date != dates[index - 1] + 1 && date != dates[index + 1] - 1 ||
            date == dates[index - 1] + 1 && date != dates[index + 1] - 1
        condensed_dates += date.to_s + ', '
      end
    end
    return condensed_dates
  end

  def performance?(days, day)
    return days.include?(day.day) ? "calendar-show-day" : "calendar-no-show-day"
  end

  def time_warning
    return "NOTE: Late night performance - For the purposes of listings, each day begins at 5am e.g. a performance listed as 2am Monday refers to a performance starting in the early hours of Tuesday morning."
  end
end

