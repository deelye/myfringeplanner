class PlannersController < ApplicationController
  def show
  end

  def edit
  end

  def create
    @performance = Performance.find(params[:performance_id])
    @planner = Planner.create!(user: current_user, performance: @performance)
    redirect_to planner_path
  end

  def destroy
    @planner = Planner.find(params[:id])
    @planner.destroy
    redirect_to planner_path
  end
end
