class WorkoutManager
    attr_reader :workout
  
    def initialize(workout_id)
      @workout = Workout.find(workout_id)
    end

    def add_exercise(exercise_params)
      # Assuming exercise_params is a hash with necessary exercise information
      # You may need to create a WorkoutExercise model or similar if it doesn't exist
      @workout.exercises.create(exercise_params)
    end
  
    # Updates an existing exercise within the workout
    def update_exercise(exercise_id, update_params)
      exercise = @workout.exercises.find(exercise_id)
      exercise.update(update_params)
    end
  
    # Completes an exercise and records it in ExerciseHistory
    def complete_exercise(exercise_id, completion_params)
      exercise_history_params = completion_params.merge({
        workout_id: @workout.id,
        exercise_id: exercise_id,
        user_id: @workout.user_id
      })
  
      ExerciseHistory.create(completion_params)
    end
  end