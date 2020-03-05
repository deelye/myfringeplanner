class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def planner
    @shortlists = current_user.shortlists
    @planners = current_user.planners
  end
end
