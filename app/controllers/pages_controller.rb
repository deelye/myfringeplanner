class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def shortlist
    @follows = current_user.all_follows
  end

  def planner
    @collection = ("01/08/2020".to_datetime.."31/08/2020".to_datetime).map { |date| date.to_date.strftime("%A %e %B") }
    if params[:day].present?
      @date = params[:day].to_datetime
      @day = params[:day].to_datetime.day
      @dayname = params[:day].to_datetime.strftime('%A %e %B')
    else
      @day = 1
      @dayname = ("01/08/2020").to_datetime.strftime('%a-%d-%m')
    end
    @planners = current_user.planners.map{ |planner| planner.day == @date ? planner : false}
    @raw_performances = current_user.all_follows.map{|performance| performance.followable.performances}.flatten.select { |performance| performance.start.day == @day }
    @booked_performance = current_user.planned_performances.select { |performance| performance.start.day == @day }
    @performances = @raw_performances - @booked_performance
    @performances.sort_by! { |performance| performance.start }
  end
end
