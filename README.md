# Asssignment

## Approach & Explanation

Time taken: Roughly 12 hours

Architecture:
- Rails 6, API mode
- Postgres
- Rest API

Gems used:
- devise
- devise_token_auth
- jbuilder

Development/Test gems used:
- rspec
- shoulda_matchers
- factory_bot
- faker
- database_cleaner
- annotate


Different user actions were required for trainers and trainees. I separated these actions with the way I implemented the action routes - e.g. separate namespaces for trainer routes and trainee routes. I also used devise_token_auth to authenticate and identify users between requests. This way, it was straightforward to manage authorization for the two types of users.

I developed this app using TDD, hence there is a rather complete test suite for the models and endpoints.

I used jbuilder to build the json responses.

I added some error handling for the endpoints, in order to ensure that good quality error messages are returned.

Below are some notes that I wrote during development.


## Notes

### Context

Trainees select trainers.
Trainers create and assign workouts to trainees.
Workouts consist of multiple exercises.
Exercises have a fixed duration


### Main Actions

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


### Todo

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
