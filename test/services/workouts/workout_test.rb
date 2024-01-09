# typed: strict

require 'test_helper'

module Workouts
  class WorkoutTest < ActiveSupport::TestCase


    def setup
      @goal = { reps: 1, weight: 275, repeats: 1 }
      @sample_exercise = ::Exercise.create!(title: "Bench Press")
    end

    test 'creates an empty workout domain object and sets all fields' do
        workout = Workouts::Workout.new
        
        assert_equal [], workout.exercises
    end

    test 'adds exercise to workout' do
        workout = Workouts::Workout.new
      
        assert_equal [], workout.exercises
      
        exercise = Workouts::Exercise.new(exercise_id: @sample_exercise.id, goal: @goal)
        workout.add_exercise(exercise: exercise)
      
        assert_equal 1, workout.exercises.length
        assert_equal @sample_exercise.id, workout.exercises.first.exercise_id
        assert_equal @goal, workout.exercises.first.goal
    end

    test 'updates properties of an exercise in the workout' do
        workout = Workouts::Workout.new
        ::Exercise.create!(title: "Bench Press")
        exercise = Workouts::Exercise.new(exercise_id: @sample_exercise.id, goal: @goal)
        workout.add_exercise(exercise: exercise)
      
        new_goal = { reps: 1, weight: 315, repeats: 1 }
        workout.update_exercise(workout_exercise_id: exercise.id, goal: new_goal)
      
        assert_equal 1, workout.exercises.length
        assert_equal new_goal, workout.exercises.first.goal
      end

  end
end
