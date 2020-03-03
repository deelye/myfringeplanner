class ShowsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @shows = Show.all
  end

  def show
    @show = Show.find(params[:id])

    @marker = {
      lat: @show.venue.latitude,
      lng: @show.venue.longitude,
    }
  end
end
