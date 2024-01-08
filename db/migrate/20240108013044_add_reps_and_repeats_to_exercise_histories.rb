class AddRepsAndRepeatsToExerciseHistories < ActiveRecord::Migration[7.1]
  def change
    add_column :exercise_histories, :reps, :integer
    add_column :exercise_histories, :repeats, :integer
    add_column :exercise_histories, :weight, :integer
  end
end
