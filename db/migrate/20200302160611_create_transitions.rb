class CreateTransitions < ActiveRecord::Migration[6.0]
  def change
    create_table :transitions do |t|
      t.references :planner_to
      t.references :planner_from
      t.timestamps
    end
  end
end
