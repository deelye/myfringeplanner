class ShowsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_show, only: [:show, :follow, :unfollow]

  def index
    if params[:filter]
      @shows = Show.all

      @start_date = params[:filter][:start_date].to_datetime
      @fringe_start_date = Time.new(@start_date.year, @start_date.month, @start_date.day, 06, 00, 00) unless @start_date.nil?

      @end_date = params[:filter][:end_date].to_datetime
      @fringe_end_date = Time.new(Time.now.year, 8, (@end_date.day + 1), 05, 59, 59) unless @end_date.nil?

      if params[:filter][:start_date].present? && params[:filter][:end_date].present?
        if @start_date > @end_date
          @shows = Show.all
          flash[:notice] = "Uh oh! Please make sure your start date comes before your end date!"
        else
          @shows = Performance.shows_between(@fringe_start_date, @fringe_end_date)
        end
      elsif params[:filter][:start_date].present?
        @fringe_end_date = Time.new(@start_date.year, 8, (@start_date.day + 1), 05, 59, 59)
        @shows = Performance.shows_between(@fringe_start_date, @fringe_end_date)
      elsif params[:filter][:end_date].present?
        @fringe_start_date = Time.new(@end_date.year, 8, @end_date.day, 06, 00, 00)
        @shows = Performance.shows_between(@fringe_start_date, @fringe_end_date)
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
