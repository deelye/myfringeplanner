class ShowsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_show, only: [:show, :follow, :unfollow]

  def index
    if params[:filter]
      @shows = Show.all
      @start_date = ("#{params[:filter][:start_date]}/08/2020").to_datetime
      @end_date = ("#{params[:filter][:end_date]}/08/2020").to_datetime
      if params[:filter][:start_date].present? && params[:filter][:end_date].present?
        @shows = Performance.shows_between(@start_date, @end_date)
      end
      if params[:filter][:genre].present?
        @shows = @shows.select{|r| r.genre == params[:filter][:genre]}
      end
      if params[:filter][:show].present?
        @shows = @shows.select{|r| r.title.downcase.match?(params[:filter][:show].downcase)}
      end
    else
      @shows = Show.includes(:performances, :venue).all
    end
  end

  def follow
    current_user.follow(@show)
    redirect_to request.referrer
  end

  def unfollow
    current_user.stop_following(@show)
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
