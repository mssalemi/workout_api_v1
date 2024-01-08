module Workout
    class Workout
      attr_accessor :exercises, :date, :template_id, :supersets
  
      def initialize(exercises = [], date = Date.today, template_id = nil, supersets = [])
        @exercises = exercises
        @date = date
        @template_id = template_id
        @supersets = supersets
      end
  
      def add_exercise(exercise)
        @exercises << exercise
      end
  
      def reorder_exercises(order)
        @exercises = order.map { |index| @exercises[index] }
      end
  
      def complete
        return unless @exercises.any?
  
        # Create a workout history entry for each exercise in the workout
        @exercises.each do |exercise|
          history_data = {
            user_id: user_id, # You may need to provide the user_id
            exercise_id: exercise.exercise_id,
            date: @date,
            reps: exercise.data.reps,
            repeats: exercise.data.repeats,
            weight: exercise.data.weights,
            notes: exercise.data.notes,
            completed_on: date # Assuming you want to set the completed_on date to the workout date
          }
  
          history_service.add_exercise_history(history_data)
        end
      end
  
      private
  
      def user_id
        # Implement your logic to retrieve the user_id here
        "0"
      end
  
      def history_service
        @history_service ||= Exercises::HistoryService.new(user_id)
      end
    end
  end
  