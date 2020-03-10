class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def shortlist
    @follows = current_user.all_follows
  end

  def planner
    @collection = ["Choose date..."]
    ("01/08/2020".to_datetime.."31/08/2020".to_datetime).map { |date| @collection << date.to_date.strftime("%A %e %B") }

    if params[:day].present? && params[:day] != "Choose date..."
      @date = params[:day].to_datetime
      @day = params[:day].to_datetime.day
      @dayname = params[:day].to_datetime.strftime('%A %e %B')
    else
      @dayname = "Choose date..."
    end

    @planners = current_user.planners.map { |planner| planner.day == @date ? planner : false}.reject { |r| r == false }
    @performances = current_user.shortlist_events.select{ |performance| performance.start.day == @day }
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
