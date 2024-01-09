# Workout Application Schema

## Description

The Workout application provides a comprehensive framework for managing workouts, exercises, and exercise history records. It empowers users to track their fitness journey effectively.

## Models and Attributes

### Exercise Model

- **Attributes**:
  - `title`: String - Title of the exercise
  - `description`: String - Description of the exercise
  - `instruction`: String - Instructions for performing the exercise
  - `body_part`: String - Body part targeted by the exercise

### User Model

- **Attributes**:
  - `name`: String - User's name
  - `email`: String - User's email address

### ExerciseHistory Model

- **Attributes**:
  - `user_id`: References - Foreign key referencing `User`
  - `exercise_id`: References - Foreign key referencing `Exercise`
  - `date`: Date - Date when the exercise was performed
  - `reps`: Integer - Total number of repetitions performed
  - `repeats`: Integer - Number of times the exercise was repeated in a session
  - `weight`: Integer - Weight used for the exercise
  - `notes`: Text - Additional notes

## My Rails Commands

### Generated Models

The created necessary models, the following Rails commands were used:

```ruby
rails g model Exercise title:string description:string instruction:string body_part:string
rails g model User name:string email:string
rails g model ExerciseHistory user:references exercise:references date:date reps:integer repeats:integer weight:integer notes:text
```

## Current Database Schema

### User Table

| id | name | email |
|----|------|-------|
| 1  | John | ...   |

### Exercise Table

| id | title       | description | body_part |
|----|-------------|-------------|-----------|
| 1  | Bench Press | ...         | Chest     |

### ExerciseHistory Table

| id | user_id | exercise_id | date       | reps | repeats | weight | notes |
|----|---------|-------------|------------|------|---------|--------|-------|
| 1  | 1       | 1           | 2024-01-07 | 30   | 3       | 50     | ...   |

## Exercises::HistoryService

The `Exercises::HistoryService` provides essential functionality for managing exercise history records. Here's how you can utilize it:

```ruby
# Initialize the service with a specific user_id
service = Exercises::HistoryService.new(user_id)

# To add a new exercise history for the user
new_history = service.add_exercise_history(
  exercise_id: 2, 
  date: Date.today, 
  reps: 10, 
  repeats: 3, 
  weight: 50,
  notes: "Felt good"
)

# To update an existing exercise history for the user
updated_history = service.update_exercise_history(
  history_id, 
  weight: 55, 
  reps: 12, 
  repeats: 4
)

# Search for all exercise histories for the user
all_histories = service.search_exercise_history

# Search for exercise histories by a specific exercise ID
histories_by_exercise = service.search_exercise_history(exercise_id: specific_exercise_id)

# Search for exercise histories by body part
histories_by_body_part = service.search_exercise_history(body_part: 'Chest')

# Example usage: Aggregating bench press data over a specific date range
aggregated_data = service.aggregate_exercise_history(
  exercise_id: bench_press_id, 
  start_date: Date.new(2022, 1, 1), 
  end_date: Date.new(2022, 12, 31)
)
```

### Sorbet

generate type files

```shell
bundle exec srb tc
```