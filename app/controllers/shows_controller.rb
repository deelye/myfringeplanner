class ShowsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_show, only: [:show, :follow, :unfollow]

  def index
    if params[:filter]
      if params[:filter][:show].present? && params[:filter][:genre].present?
        @shows = Show.includes(:performances, :venue).where(genre: params[:filter][:genre]).search(params[:filter][:show])
      elsif params[:filter][:show].present?
        @shows = Show.includes(:performances, :venue).search(params[:filter][:show])
      elsif params[:filter][:genre].present?
        @shows = Show.includes(:performances, :venue).where(genre: params[:filter][:genre])
      elsif params[:filter][:show].blank? && params[:filter][:genre].blank?
        @shows = Show.includes(:performances, :venue).all
      end
    elsif params[:category]
      @shows = Show.includes(:performances, :venue).where(genre: params[:category])
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
