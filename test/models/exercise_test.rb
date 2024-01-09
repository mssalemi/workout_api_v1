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
  end
end
