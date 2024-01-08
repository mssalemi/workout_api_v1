# Workout Application Schema

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

## Rails Commands

### Generate Models

```ruby
rails g model Exercise title:string description:string instruction:string body_part:string
rails g model User name:string email:string
rails g model ExerciseHistory user:references exercise:references date:date reps:integer repeats:integer weight:integer notes:text
```

### Generate GraphQL Object

```ruby
rails g graphql:object exercise
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

---

This format presents a clear view of the different models in your application, their attributes, and the associated Rails commands for generating these models and a GraphQL object. It also includes the current structure of your database tables.