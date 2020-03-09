class Planner < ApplicationRecord
  belongs_to :user
  belongs_to :performance
  has_many :arriving_transitions, class_name: "Transition", foreign_key: :planner_to_id
  has_many :departing_transitions, class_name: 'Transition', foreign_key: :planner_from_id
  before_save :set_top_and_duration

  def set_top_and_duration
    dur_in_5 = (self.performance.end - self.performance.start) / 300
    top_in_5 = (self.performance.start - (self.performance.start.beginning_of_day + (3600 * 10))) / 300
    self.duration = ((dur_in_5 / 168) * 100).round(2).to_s + "%"
    self.top = ((top_in_5 / 168) * 100).round(2).to_s + "%"
  end

  def planner_clash(planners, planner)
    planners.each do |p|
      if (planner.performance.start > p.performance.start && planner.performance.start < p.performance.end) || (planner.performance.end > p.performance.start && planner.performance.end < p.performance.end)
        return "planner-clash"
      end
    end
  end
end
