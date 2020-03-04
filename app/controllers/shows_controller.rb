class ShowsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  # def index
  #   @shows = Show.all
  def index
    if params[:filter] # filter by category and title
      if params[:filter][:show].present? && params[:filter][:genre].present?
        @shows = Show.where(genre: params[:filter][:genre]).search(params[:filter][:show])
      elsif params[:filter][:show].present?
        @shows = Show.search(params[:filter][:show])

      elsif params[:filter][:genre].present?
        @shows = Show.where(genre: params[:filter][:genre])
      end
    else
      @shows = Show.all
    end
    @performances = Performance.all

  end


  def show
    @show = Show.find(params[:id])

    @marker = {
      lat: @show.venue.latitude,
      lng: @show.venue.longitude,
    }
  end
end
