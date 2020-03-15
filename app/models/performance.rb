class Performance < ApplicationRecord
  belongs_to :show
  has_many :planners

  def self.shows_between(start_date, end_date)
    includes(:show).joins(:show).where("start >= ? and start <= ?", start_date, end_date ).map(&:show).uniq
  end

  def self.shows_on(start_date)
    all.select { |p| p.start.day == start_date.day }.map(&:show).uniq
  end

  def time
    @start = self.start.strftime("%R")
    @end = self.end.strftime("%R")

    "#{@start} - #{@end}"
  end

  def shortlist_clash(planners, performance)
    planners.each do |planner|
      if (performance.start >= planner.performance.start && performance.start <= planner.performance.end) || (performance.end >= planner.performance.start && performance.end <= planner.performance.end)
        return "planner-clash"
      end
    end
  end
end
