class ShowsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_show, only: [:show, :follow, :unfollow]

  def index
    if params[:filter]
      @shows = Show.all
      @start_date = params[:filter][:start_date].to_datetime
      @end_date = params[:filter][:end_date].to_datetime

      if params[:filter][:start_date].present? && params[:filter][:end_date].present?
        if @start_date == @end_date
          @shows = Performance.shows_on(@start_date)
        elsif @start_date > @end_date
          @shows = Show.all
          flash[:notice] = "Uh Oh! Did you flip your dates? Please make sure your start date comes before your end date."
        else
          @shows = Performance.shows_between(@start_date, @end_date)
        end
      elsif params[:filter][:start_date].present? || params[:filter][:end_date].present?
        @start_date.nil? ? date = @end_date : date = @start_date
        @shows = Performance.shows_on(date)
      end

      if params[:filter][:genre].present?
        @shows = @shows.select {|show| show.genre == params[:filter][:genre] }
      end
      if params[:filter][:show].present?
        # @shows = @shows.select{|r| r.title.downcase.match?(params[:filter][:show].downcase)}
        @shows = Show.search(params[:filter][:show])
      end
      if @shows.first.nil?
        @shows = Show.all
        flash[:notice] = "No results found"
      end
    else
      @shows = Show.includes(:performances, :venue).all
      if params[:category].present?
        @shows = @shows.select do |r|
          if params[:category] == "Comedy" || params[:category] == "Cabaret and Variety" || params[:category] == "Dance Physical Theatre and Circus"
            r.genre == params[:category]
          elsif params[:category] == "Musicals and Opera"
            r.genre == params[:category] || r.genre == "Theatre"
          elsif params[:category] == "Events"
            r.genre == params[:category] || r.genre == "Exhibitions"
          elsif params[:category] == "Children's Shows"
            r.genre == params[:category] || r.genre == "Spoken Word" || r.genre == "Music"
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
    @planners << Planner.all.select {|planner| planner.performance.show == @show }
    if !@planners.flatten.first.nil?
      @planners.each { |planner| planner.first.delete }
    end
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
