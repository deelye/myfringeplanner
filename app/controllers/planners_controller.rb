class PlannersController < ApplicationController
  def show
  end

  def edit
  end

  def create
    @day = params[:day]
    @performance = Performance.find(params[:performance_id])
    @planner = Planner.create!(user: current_user, performance: @performance)
    redirect_to planner_path(day: @day)
  end

  def destroy
    @day = params[:day]
    @planner = Planner.find(params[:id])
    @planner.destroy
    redirect_to planner_path(day: @day)
  end
end
