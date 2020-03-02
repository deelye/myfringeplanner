class AddPriceToPerformances < ActiveRecord::Migration[6.0]
  def change
    add_column :performances, :price, :integer
  end
end
