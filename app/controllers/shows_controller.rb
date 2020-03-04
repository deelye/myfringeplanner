class ShowsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_show, only: [:show, :follow, :unfollow]
  # def index
  #   @shows = Show.all
  def index
    if params[:filter] # filter by category and title
      if params[:filter][:show].present? && params[:filter][:genre].present?
        @shows = Show.includes(:performance, :venue).where(genre: params[:filter][:genre]).search(params[:filter][:show])
      elsif params[:filter][:show].present?
        @shows = Show.includes(:performance, :venue).search(params[:filter][:show])

      elsif params[:filter][:genre].present?
        @shows = Show.includes(:performance, :venue).where(genre: params[:filter][:genre])
      end
    else
      @shows = Show.all
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
    }
  end

  private

  def set_show
    @show = Show.find(params[:id])
  end
end
