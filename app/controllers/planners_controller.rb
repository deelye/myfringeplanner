class PlannersController < ApplicationController
  def index
    @hand = false
    @planners = Planner.where(user: current_user).sort_by { |planner| planner.performance.start }
  end

  def create
    @day = params[:day]
    @performance = Performance.find(params[:performance_id])
    @planner = Planner.create!(user: current_user, performance: @performance, day: @day)
    redirect_to planner_path(day: @day)
  end

  def destroy
    @day = params[:day]
    @planner = Planner.find(params[:id])
    @planner.destroy
    redirect_to planner_path(day: @day)
  end
end
