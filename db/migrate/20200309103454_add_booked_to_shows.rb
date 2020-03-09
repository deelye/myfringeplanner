class AddBookedToShows < ActiveRecord::Migration[6.0]
  def change
    add_column :shows, :booked, :boolean, default: false
  end
end
