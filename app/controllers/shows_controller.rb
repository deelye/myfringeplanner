class ShowsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
    @shows = Show.all
  end

  def show
    @show = Show.find(params[:id])
  end
end
