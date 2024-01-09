require 'test_helper'

module Workouts
  class ExerciseTest < ActiveSupport::TestCase
    def setup
      @exercise = ::Exercise.create!(title: "Bench Press")
      @goal = { reps: 10, weight: 200, repeats: 3 }
    end

    test 'initializes an exercise with given attributes' do
      workout_exercise = Workouts::Exercise.new(exercise_id: @exercise.id, goal: @goal)

      assert workout_exercise
      assert_equal @exercise.id, workout_exercise.exercise_id
      assert_equal @goal, workout_exercise.goal
    end

    test 'updates the goal of the exercise' do
      workout_exercise = Workouts::Exercise.new(exercise_id: @exercise.id, goal: @goal)
      new_goal = { reps: 12, weight: 250, repeats: 4 }

      workout_exercise.update_goal(goal: new_goal)

      assert_equal new_goal, workout_exercise.goal
    end

    test 'raises an error for invalid goal' do
      workout_exercise = Workouts::Exercise.new(exercise_id: @exercise.id, goal: @goal)
      invalid_goal = { reps: -1, weight: 250 } # Missing :repeats and invalid :reps

      assert_raises(RuntimeError) do
        workout_exercise.update_goal(goal: invalid_goal)
      end
    end
  end
end
