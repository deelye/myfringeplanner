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
    # @months = [Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec]
  end
  # if params[:query].present?
  #   @search_term = params[:query]
  #   @shows = Show.
  # else
  # end

  #     @groups = @shows.group_by { |s| s.category }
  #   end
  # end

  def show
    @show = Show.find(params[:id])

    @marker = {
      lat: @show.venue.latitude,
      lng: @show.venue.longitude,
    }
  end
end
