class RemoveShowFromPlanners < ActiveRecord::Migration[6.0]
  def change
    remove_reference :planners, :show
  end
end
