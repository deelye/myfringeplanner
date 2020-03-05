class AddColumnsToPlanners < ActiveRecord::Migration[6.0]
  def change
    add_column :planners, :top, :string
    add_column :planners, :duration, :string
  end
end
