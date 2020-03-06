class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def shortlist
    @follows = current_user.all_follows
  end

  def planner
    @day = "07/08/2020".to_datetime.day
    @planners = current_user.planners
    @raw_performances = current_user.all_follows.map{|r| r.followable.performances}.flatten.select{|r| r.start.day == @day}
    @booked_performance = current_user.planned_performances.select{|r| r.start.day == @day}
    @performances = @raw_performances - @booked_performance
  end
end
