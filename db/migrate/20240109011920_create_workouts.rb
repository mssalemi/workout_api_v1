class CreateWorkouts < ActiveRecord::Migration[7.1]
  def change
    create_table :workouts do |t|
      t.integer :template_id
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
