class ShowsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
    @shows = Show.all
  end
end
