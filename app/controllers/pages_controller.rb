class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :about ]

  def shortlist
    @follows = current_user.all_follows
  end

  def planner
    @hand = true
    if params[:day].present?
      @date = params[:day].to_datetime
      @day = params[:day].to_datetime.day
      @dayname = @date.strftime('%A %e %B')
    else
      @dayname = "Choose a date from above..."
    end

    @planners = current_user.planners.map { |planner| planner.day == @date ? planner : false }.reject { |performance| performance == false }
    if @date.nil?
      @performances = current_user.shortlist_events.select { |performance| performance.start.day == @day }
    else
      @performances = current_user.shortlist_events.select do |performance|
        performance.start >= @date + 0.25 && performance.start < @date + 1.25
      end
    end

    @performances.sort_by! { |performance| performance.start }

    @markers = @planners.map do |booking|
      {
        lat: booking.performance.show.venue.latitude,
        lng: booking.performance.show.venue.longitude,
        plannerInfoWindow: render_to_string(partial: "planner_info_window", locals: { booking: booking })
      }
    end
  end

end
