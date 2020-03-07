class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def shortlist
    @follows = current_user.all_follows
  end

  def planner
    @collection = ("01/08/#{Time.now.year}".to_datetime.."31/08/#{Time.now.year}".to_datetime).map { |day| day.to_date }

    if params[:day].present?
      @day = params[:day].to_datetime.day
      @dayname = params[:day].to_datetime.strftime('%A %d %^B')
    else
      @day = 1
      @dayname = ("01/08/#{Time.now.year}").to_datetime.strftime('%A %d %^B')
    end

    @planners = current_user.planners
    @raw_performances = current_user.all_follows.map { |show| show.followable.performances }.flatten.select { |performance| performance.start.day == @day }
    @booked_performance = current_user.planned_performances.select { |performance| performance.start.day == @day }
    @performances = @raw_performances - @booked_performance
  end
end
