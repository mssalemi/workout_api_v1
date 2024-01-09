# typed: strict

module Workouts
    class Exercise
        extend T::Sig
    
        sig { returns(String) }
        attr_accessor :id

        sig { returns(Integer) }
        attr_accessor :exercise_id
    
        sig { returns(T::Hash[Symbol, Integer]) }
        attr_accessor :goal
    
        sig { params(exercise_id: Integer, goal: T::Hash[Symbol, Integer]).void }
        def initialize(exercise_id:, goal:)
            raise "Invalid goal" unless validate_exercise_goal?(goal)
            @id = T.let(SecureRandom.uuid, String)
            @exercise_id = exercise_id
            @goal = goal
            @completed = T.let(false, T::Boolean)
            @exercise_history_id = T.let(nil, T.nilable(Integer))
        end
    
        sig { params(user_id: Integer, actual_reps: Integer, actual_weight: Integer, actual_repeats: Integer).returns(T.untyped) }
        def complete(user_id:, actual_reps:, actual_weight:, actual_repeats:)
            exercise = T.unsafe(::Exercise.find(exercise_id))
    
            raise "Exercise not found - NOT TRACKABLE ERROR" unless exercise
    
            history = T.unsafe(ExerciseHistory.create!(
                    user_id: user_id,
                    exercise_id: exercise.id,
                    date: Date.today,
                    reps: actual_reps,
                    weight: actual_weight,
                    repeats: actual_repeats,
                )
            )
    
            @completed = true
            @exercise_history_id = history.id
    
            history
        end

        sig { params(goal: T::Hash[Symbol, Integer]).void }
        def update_goal(goal:)
          raise "Invalid goal" unless validate_exercise_goal?(goal)
          @goal = goal
        end
    
    
        private
    
        sig { params(goal: T::Hash[Symbol, Integer]).returns(T::Boolean) }
        def validate_exercise_goal?(goal)
            goal.is_a?(Hash) &&
            goal.key?(:reps) &&
            goal.key?(:weight) &&
            goal.key?(:repeats)
        end
    end
end
  