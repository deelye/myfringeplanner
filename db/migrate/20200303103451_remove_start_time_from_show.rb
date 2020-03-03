class RemoveStartTimeFromShow < ActiveRecord::Migration[6.0]
  def change
    remove_column :shows, :start_time
  end
end
