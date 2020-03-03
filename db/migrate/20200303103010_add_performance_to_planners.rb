class AddPerformanceToPlanners < ActiveRecord::Migration[6.0]
  def change
    add_reference :planners, :performance
  end
end
