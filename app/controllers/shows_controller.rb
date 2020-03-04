class ShowsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @shows = Show.all
    @performances = Performance.all
    # @months = [Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec]
  end

  def show
    @show = Show.find(params[:id])

    @marker = {
      lat: @show.venue.latitude,
      lng: @show.venue.longitude,
    }
  end
end
