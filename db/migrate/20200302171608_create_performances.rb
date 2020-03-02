class CreatePerformances < ActiveRecord::Migration[6.0]
  def change
    create_table :performances do |t|
      t.references :show, null: false, foreign_key: true
      t.datetime :date
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
