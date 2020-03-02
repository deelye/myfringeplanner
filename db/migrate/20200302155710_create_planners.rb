class CreatePlanners < ActiveRecord::Migration[6.0]
  def change
    create_table :planners do |t|
      t.references :user, null: false, foreign_key: true
      t.references :show, null: false, foreign_key: true

      t.timestamps
    end
  end
end
