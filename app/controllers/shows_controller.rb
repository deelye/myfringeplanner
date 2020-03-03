class ShowsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @shows = Show.all
    @performances = Performance.all
  end

  def show
    @show = Show.find(params[:id])
  end
end
