class ShowsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  # def index
  #   @shows = Show.all
  def index
    @shows = Show.where("title ILIKE ?", "%#{params[:query]}%")
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
  end
end
