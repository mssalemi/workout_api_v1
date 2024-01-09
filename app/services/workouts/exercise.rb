module Workouts
    class Exercise
        attr_accessor :exercise_id, :goal

        def initialize(exercise_id:, goal:)
            raise "Invalid goal" unless validate_exercise_goal?(goal)

            @exercise_id = exercise_id
            @goal = goal
            @completed = false
            @exercise_history_id = nil
        end

        def complete(user_id:, actual_reps:, actual_weight:, actual_repeats:)
            exercise = ::Exercise.find(exercise_id)

            raise "Exercise not found" unless exercise

            history = ExerciseHistory.create!(
              user_id: user_id,
              exercise_id: exercise.id,
              date: Date.today,
              reps: actual_reps,
              weight: actual_weight,
              repeats: actual_repeats,
            )

            @completed = true
            @exercise_history_id = history.id
            
            history
          end

        private

        def validate_exercise_goal?(goal)
            goal.is_a?(Hash) &&
            goal.key?(:reps) &&
            goal.key?(:weight) &&
            goal.key?(:repeats)
        end
    end
end