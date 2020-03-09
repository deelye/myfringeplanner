class Performance < ApplicationRecord
  belongs_to :show
  has_many :planners

  def self.shows_between(start_date, end_date)
    includes(:show).joins(:show).where("start >= ? and start <= ?", start_date, end_date ).map(&:show).uniq
  end

  def time
    @start = self.start.strftime("%R")
    @end = self.end.strftime("%R")

    "#{@start} - #{@end}"
  end
end
