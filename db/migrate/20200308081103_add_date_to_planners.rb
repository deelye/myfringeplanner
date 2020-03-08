class AddDateToPlanners < ActiveRecord::Migration[6.0]
  def change
    add_column :planners, :day, :datetime
  end
end
