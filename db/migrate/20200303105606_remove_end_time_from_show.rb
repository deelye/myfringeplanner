class RemoveEndTimeFromShow < ActiveRecord::Migration[6.0]
  def change
    remove_column :shows, :end_time
  end
end
