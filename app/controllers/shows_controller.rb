class ShowsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_show, only: [:show, :follow, :unfollow]

  def index
    if params[:filter]
      if params[:filter][:start_date].present? || params[:filter][:end_date].present?
        if params[:filter][:start_date].present? && params[:filter][:end_date].present? && params[:filter][:start_date].to_datetime > params[:filter][:end_date].to_datetime
          flash[:notice] = "Uh oh! Please make sure your start date comes before the end date!"
        else
          @fringe_start_date = params[:filter][:start_date].present? ? params[:filter][:start_date].to_datetime + 0.25 : params[:filter][:end_date].to_datetime + 0.25
          @fringe_end_date = params[:filter][:end_date].present? ? (params[:filter][:end_date] + " 05:59").to_datetime + 1 : (params[:filter][:start_date] + " 05:59").to_datetime + 1
          @shows = Performance.shows_between(@fringe_start_date, @fringe_end_date)
        end
      else
        @shows = Show.all
      end

      if params[:filter][:genre].present?
        @shows = @shows.select {|show| show.genre == params[:filter][:genre] }
      end

      if params[:filter][:show].present?
        @shows = Show.search(params[:filter][:show])
      end

      if @shows.first.nil?
        @shows = Show.all
        flash[:notice] = "Sorry, no results found."
      end
    else
      @shows = Show.includes(:performances, :venue).all
      if params[:category].present?
        @shows = @shows.select do |show|
          if params[:category] == "Comedy" || params[:category] == "Cabaret and Variety" || params[:category] == "Dance Physical Theatre and Circus"
            show.genre == params[:category]
          elsif params[:category] == "Musicals and Opera"
            show.genre == params[:category] || show.genre == "Theatre"
          elsif params[:category] == "Events"
            show.genre == params[:category] || show.genre == "Exhibitions"
          elsif params[:category] == "Children's Shows"
            show.genre == params[:category] || show.genre == "Spoken Word" || show.genre == "Music"
          end
        end
      end
    end
  end

  def follow
    current_user.follow(@show)
    redirect_to request.referrer
  end

  def unfollow
    current_user.stop_following(@show)
    @planners = []
    @planners << Planner.all.select { |planner| planner.performance.show == @show }
    @planners.each { |planner| planner.first.delete } if !@planners.flatten.first.nil?

    redirect_to request.referrer
  end

  def show
    @marker = {
      lat: @show.venue.latitude,
      lng: @show.venue.longitude,
      infoWindow: render_to_string(partial: "info_window", locals: { show: @show })
    }
  end

  private

  def set_show
    @show = Show.find(params[:id])
  end
end
