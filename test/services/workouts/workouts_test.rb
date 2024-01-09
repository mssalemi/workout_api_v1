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

    test 'adds exercise to workout' do
        workout = Workouts::Workout.new
        
        assert_equal [], workout.exercises

        ::Exercise.create!(title: "Bench Press")

        exercise = Workouts::Exercise.new(exercise_id: "1", goal: @goal)
        workout.add_exercise(exercise: exercise)

        assert_equal 1, workout.exercises.length
    end

    # test 'should update an existing exercise' do
    #   @workout.add_exercise(@exercise_id, @goal)
    #   new_goal = { reps: 15, weight: 55, repeats: 4 }
    #   @workout.update_exercise(@exercise_id, goal: new_goal)
    #   updated_exercise = @workout.exercises.first
    #   assert_equal new_goal, updated_exercise.goal
    # end

    # test 'should not update a non-existent exercise' do
    #   non_existent_id = 999
    #   @workout.add_exercise(@exercise_id, @goal)
    #   initial_exercises = @workout.exercises.dup
    #   @workout.update_exercise(non_existent_id, goal: { reps: 20 })
    #   assert_equal initial_exercises, @workout.exercises
    # end
  end
end
