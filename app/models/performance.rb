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

  def shortlist_clash(planners, performance)
    planners.each do |planner|
      if (performance.start > planner.performance.start && performance.start < planner.performance.end) || (performance.end > planner.performance.start && performance.end < planner.performance.start)
        return "planner-clash"
      end
    end
  end
end
