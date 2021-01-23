# Asssignment

## Approach

- Rails 6, API mode
- Postgres
- Rest API


## Context

Trainees select trainers.
Trainers create and assign workouts to trainees.
Workouts consist of multiple exercises.
Exercises have a fixed duration


## Main Actions

- Trainer views a workout
- Trainer creates a workout
- Trainer updates a workout
- Trainer deletes a workout
- Trainer views all of their trainees
- Trainer assigns a workout for a trainee

- Trainee chooses a trainer based on desired expertise (Sounds like 2 actions):
  - Trainee views trainers, filterable by trainer expertise
  - Trainee selects a trainer
- Trainee overviews all workouts, filterable by time period


## Notes / Todo

- generate new rails app in api mode

  rails new vaha_assignment --api -d postgresql

- install rspec

- generate models
  - user
    - trainer
    - trainee
    - join table: trainee_trainer
  - workout
    - join table: trainee_workout
  - exercise
    - join table: workout_exercise
  - expertise

- add seed data for exercises and expertises

- install devise & devise_token_auth for identifying user sessions
  - `rails g devise_token_auth:install User auth`

- generate main routes
  - namespace the endpoints
    `namespace :api do
      namespace :v1 do
        resources ...`

- write specs for the main actions
  - ensure errors are handled appropriately
    - appropriate http codes
    - good error messages
  - cover edge cases

- ensure app works in dev mode
  - rack-cors
  - (test using postman, etc)
