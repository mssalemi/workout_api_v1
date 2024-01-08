module Workout
    class Exercise
      Goal = Struct.new(:weights, :reps, :sets, :repeats, keyword_init: true)
      Data = Struct.new(:weights, :reps, :sets, :repeats, :completed_on, keyword_init: true)
  
      attr_accessor :user_id, :exercise, :goal, :trackable, :data
  
      def initialize(user_id, exercise, goal_attrs, trackable)
        @user_id = user_id
        @exercise = exercise
        @goal = Goal.new(goal_attrs)
        @trackable = trackable
        @data = nil # Initially no data until exercise is completed
        @history_service = Exercises::HistoryService.new(user_id)
      end
  
      def complete_exercise(data_attrs)
        record_exercise_if_trackable
        @data = Data.new(data_attrs)
      end

      def update_exercise(update_attrs)
        raise 'Exercise not yet completed' if @data.nil?
  
        # Initialize a hash to store the attributes to be updated
        updates = {}
  
        # Check if the update_attrs include specific attributes and update the 'updates' hash accordingly
        updates[:weights] = update_attrs[:weights] if update_attrs.key?(:weights)
        updates[:reps] = update_attrs[:reps] if update_attrs.key?(:reps)
        updates[:sets] = update_attrs[:sets] if update_attrs.key?(:sets)
        updates[:repeats] = update_attrs[:repeats] if update_attrs.key?(:repeats)
        updates[:completed_on] = update_attrs[:completed_on] if update_attrs.key?(:completed_on)

        @data = Data.new(@data.to_h.merge(updates)) unless updates.empty?

        # Update the exercise history records with the specified attributes
        if trackable && @data.completed_on
            @history_service.update_exercise_history(
            @data.history_id,
            weight: @data.weights,
            reps: @data.reps,
            repeats: @data.repeats
            )
        end
      end  

  
      private
  
      def record_exercise_if_trackable
        if trackable
            if @data.completed_on.nil?
                @history_service.add_exercise_history(
                    user_id: @user_id,
                    exercise_id: @exercise_id, # Assuming @exercise_id is available
                    date: @date, # You might want to set the date as well
                    reps: @data.reps,
                    repeats: @data.repeats,
                    weight: @data.weights,
                    notes: @data.notes,
                    completed_on: @data.completed_on # Include completed_on if it's part of data_attrs
                )
            else
                @history_service.update_exercise_history(
                    history_id, 
                    weight: @data.weights, 
                    reps: @data.reps, 
                    repeats: @data.repeats
                )
            end
        end
      end
    end
  end
  