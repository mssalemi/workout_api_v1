# typed: strict

require 'test_helper'

module Workouts
  class WorkoutTest < ActiveSupport::TestCase


    def setup
      @goal = { reps: 1, weight: 275, repeats: 1 }
    end

    test 'creates an empty workout domain object and sets all fields' do
        workout = Workouts::Workout.new
        
        assert_equal [], workout.exercises
    end

    test 'adds exercise to workout and updates properties' do
        workout = Workouts::Workout.new
        
        assert_equal [], workout.exercises

        ::Exercise.create!(title: "Bench Press")

        exercise = Workouts::Exercise.new(exercise_id: "1", goal: @goal)
        workout.add_exercise(exercise: exercise)

        assert_equal 1, workout.exercises.length

        new_goal = { reps: 1, weight: 315, repeats: 1 }

        workout.update_exercise(workout_exercise_id: exercise.id, goal: new_goal)

        assert_equal new_goal, workout.exercises.first.goal
    end
  end
end
