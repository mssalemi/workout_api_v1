module Workouts
    class Workout
      attr_accessor :exercises
  
      def initialize
        @exercises = []
      end
  
      def add_exercise(exercise_id, goal)
        exercise = Workouts::Exercise.new(exercise_id, goal)
        @exercises << exercise
      end
  
      def remove_exercise(exercise_id)
        @exercises.reject! { |exercise| exercise.exercise_id == exercise_id }
      end
  
      def update_exercise(exercise_id, goal: nil)
        exercise = find_exercise(exercise_id)
        return unless exercise
  
        exercise.goal = goal if goal
      end
      
      private

      def find_exercise(exercise_id)
        @exercises.find { |exercise| exercise.exercise_id == exercise_id }
      end
    end
  end
  