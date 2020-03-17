class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def shortlist
    @follows = current_user.all_follows
  end

  def planner
    @hand = true
    if params[:day].present? && params[:day] != "Choose date..."
      @date = params[:day].to_datetime
      @day = params[:day].to_datetime.day
      @dayname = @date.strftime('%A %e %B')
    else
      @dayname = "Choose date..."
    end

    @planners = current_user.planners.map { |planner| planner.day == @date ? planner : false }.reject { |performance| performance == false }
    @performances = current_user.shortlist_events.select { |performance| performance.start.day == @day }
    @performances.sort_by! { |performance| performance.start }

    if @planners == []
      @planner_start = @performances.first.start - 1800
      @planner_finish = @planners.last.end + 1800
    else
      @planners.delete_if { |planner| planner == false }.sort_by! { |planner| planner.performance.start }
      @planner_start = @planners.first.performance.start > @performances.first.start ? @performances.first.start - 1800 : @planners.first.performance.start - 1800
      @planner_finish = @planners.last.performance.end > @performances.last.end ? @planners.last.performance.end + 1800 : @performances.last.end + 1800
    end
    @height_pixels_int = ((@planner_finish - @planner_start) / 3600 * 100).to_i
    @height_pixels_string = ((@planner_finish - @planner_start) / 3600 * 100).to_i.to_s + "px"
    @height_intervals = ((@planner_finish - @planner_start) / 300).to_i

    @markers = @planners.map do |booking|
      {
        lat: booking.performance.show.venue.latitude,
        lng: booking.performance.show.venue.longitude,
        plannerInfoWindow: render_to_string(partial: "planner_info_window", locals: { booking: booking })
      }
    end
  end

end
