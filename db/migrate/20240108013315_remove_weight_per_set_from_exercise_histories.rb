class RemoveWeightPerSetFromExerciseHistories < ActiveRecord::Migration[7.0]
  def change
    remove_column :exercise_histories, :weight_per_set, :string
  end
end
