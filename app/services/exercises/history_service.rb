# app/services/exercise/history_service.rb

module Exercises
  class HistoryService
    def initialize(user_id)
      @user_id = user_id
    end

    def add_exercise_history(user_id:, exercise_id:, date:, reps:, repeats:, weight:, notes: nil)
      ExerciseHistory.create(
        user_id: @user_id,
        exercise_id: exercise_id,
        date: date,
        reps: reps,
        repeats: repeats,
        weight: weight,
        notes: notes
      )
    end


    def update_exercise_history(history_id, updated_attrs)
      history = ExerciseHistory.find_by(id: history_id, user_id: @user_id)
      return nil unless history
    
      history.update(updated_attrs)
      history
    end

    def search_exercise_history(exercise_id: nil, body_part: nil)
      query = ExerciseHistory.where(user_id: @user_id)

      query = query.where(exercise_id: exercise_id) if exercise_id
      query = query.joins(:exercise).where(exercises: { body_part: body_part }) if body_part

      query
    end

    def aggregate_exercise_history(exercise_id: nil, body_part: nil)
      raise ArgumentError, 'Exercise ID is required' unless exercise_id

      query = ExerciseHistory.where(user_id: @user_id)

      query = query.where(exercise_id: exercise_id) if exercise_id
      query = query.joins(:exercise).where(exercises: { body_part: body_part }) if body_part
      query = query.where('date >= ?', start_date) if start_date
      query = query.where('date <= ?', end_date) if end_date

      query.group(:exercise_id, :date)
           .select('exercise_id', 'date', 'SUM(weight * reps * repeats) as total_weight')
           .order(:date)
    end
  end
end
