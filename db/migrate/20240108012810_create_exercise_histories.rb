class CreateExerciseHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :exercise_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.date :date
      t.integer :sets
      t.string :reps_per_set
      t.string :weight_per_set
      t.text :notes

      t.timestamps
    end
  end
end
