class ShowsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_show, only: [:show, :follow, :unfollow]

  def index
    if params[:filter]
      @start_date = (2020, 8, params[:filter][:start_date]).to_datetime
      @end_date = (2020, 8, params[:filter][:end_date]).to_datetime

      # If all search parameters are defined
      if params[:filter][:start_date].present? && params[:filter][:end_date].present? && params[:filter][:show].present? && params[:filter][:genre].present?
        @shows = Performance.dates_between(@start_date, @end_date).map(&:show).uniq.includes(:performances, :venue).where(genre: params[:filter][:genre]).search(params[:filter][:show])
        puts "found the first"
      # Else if only dates and name are defined
      elsif params[:filter][:start_date].present? && params[:filter][:end_date].present? && params[:filter][:show].present?
        @shows = Performance.dates_between(@start_date, @end_date).map(&:show).uniq.includes(:performances, :venue).search(params[:filter][:show])
        puts "found the second"
      # Else if only dates and genre are defined
      elsif params[:filter][:start_date].present? && params[:filter][:end_date].present? && params[:filter][:genre].present?
        @shows = Performance.dates_between(@start_date, @end_date).map(&:show).uniq.includes(:performances, :venue).where(genre: params[:filter][:genre])
      # Else if only dates are defined
      if params[:filter][:start_date].present? && params[:filter][:end_date].present?
        @shows = Performance.dates_between(@start_date, @end_date).map(&:show).uniq.includes(:performances, :venue)

      # Else if start date, genre, and name are defined
      elsif params[:filter][:start_date].present? && params[:filter][:show].present? && params[:filter][:genre].present?
        @shows = Performance.dates_between(@start_date, DateTime.new(2020, 8, 31)).map(&:show).uniq.includes(:performances, :venue).where(genre: params[:filter][:genre]).search(params[:filter][:show])
      # Else if start date and name are defined
      elsif params[:filter][:start_date].present? && params[:filter][:show].present?
        @shows = Performance.dates_between(@start_date, DateTime.new(2020, 8, 31)).map(&:show).uniq.includes(:performances, :venue).search(params[:filter][:show])
      # Else if start date and genre are defined
      elsif params[:filter][:start_date].present? && params[:filter][:genre].present?
        @shows = Performance.dates_between(@start_date, DateTime.new(2020, 8, 31)).map(&:show).uniq.includes(:performances, :venue).where(genre: params[:filter][:genre])

      # Else if end date, genre, and name are defined
      elsif params[:filter][:end_date].present? && params[:filter][:show].present? && params[:filter][:genre].present?
        @shows = Performance.dates_between(DateTime.new(2020, 8, 1), @end_date).map(&:show).uniq.includes(:performances, :venue).where(genre: params[:filter][:genre]).search(params[:filter][:show])
      # Else if end date and name are defined
      elsif params[:filter][:end_date].present? && params[:filter][:show].present?
        @shows = Performance.dates_between(DateTime.new(2020, 8, 1), @end_date).map(&:show).uniq.includes(:performances, :venue).search(params[:filter][:show])
      # Else if end date and genre are defined
      elsif params[:filter][:end_date].present? && params[:filter][:genre].present?
        @shows = Performance.dates_between(DateTime.new(2020, 8, 1), @end_date).map(&:show).uniq.includes(:performances, :venue).where(genre: params[:filter][:genre])

      # Else if no dates are defined
      elsif params[:filter][:show].present? && params[:filter][:genre].present?
        @shows = Show.includes(:performances, :venue).where(genre: params[:filter][:genre]).search(params[:filter][:show])
      elsif params[:filter][:show].present?
        @shows = Show.includes(:performances, :venue).search(params[:filter][:show])
      elsif params[:filter][:genre].present?
        @shows = Show.includes(:performances, :venue).where(genre: params[:filter][:genre])
      elsif params[:filter][:show].blank? && params[:filter][:genre].blank?
         @shows = Show.includes(:performances, :venue).all
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
