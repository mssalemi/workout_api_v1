class AddWorkoutToExerciseHistories < ActiveRecord::Migration[7.1]
  def change
    add_reference :exercise_histories, :workout, null: false, foreign_key: true
  end
end
