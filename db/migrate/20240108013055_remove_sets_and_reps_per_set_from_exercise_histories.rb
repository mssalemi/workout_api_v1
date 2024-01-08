class RemoveSetsAndRepsPerSetFromExerciseHistories < ActiveRecord::Migration[7.1]
  def change
    remove_column :exercise_histories, :sets, :integer
    remove_column :exercise_histories, :reps_per_set, :string
  end
end
