# typed: strict

module Workouts
  class Workout
    extend T::Sig

    sig { returns(T::Array[Workouts::Exercise]) }
    attr_accessor :exercises

    sig { void }
    def initialize
      @exercises = T.let([], T::Array[Workouts::Exercise])
    end

    sig { params(exercise: Workouts::Exercise).void }
    def add_exercise(exercise:)
      @exercises << exercise
    end

    sig { params(workout_exercise_id: String).void }
    def remove_exercise(workout_exercise_id:)
      @exercises.reject! { |exercise| exercise.exercise_id == workout_exercise_id }
    end

    sig { params(workout_exercise_id: String, goal: T::Hash[Symbol, Integer]).void }
    def update_exercise(workout_exercise_id:, goal:)
      exercise = find_exercise(workout_exercise_id: workout_exercise_id)
      return unless exercise

      exercise.update_goal(goal: goal)

      exercise
    end
    
    private

    sig { params(workout_exercise_id: String).returns(T.nilable(Workouts::Exercise)) }
    def find_exercise(workout_exercise_id:)
      @exercises.find { |exercise| exercise.id == workout_exercise_id }
    end
  end
end
