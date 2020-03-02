class RemoveDateFromPerformances < ActiveRecord::Migration[6.0]
  def change
    remove_column :performances, :date
  end
end
