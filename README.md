# Asssignment

## Explanation

Time taken: Roughly 12 hours

Architecture:
- Ruby 2.7.2
- Rails 6, API mode
- Postgres
- Rest API


### Approach

The spec stated that "production quality code" is expected. For this reason especially, I developed the whole app using TDD in order to promote stability. At the time of writing this, all of the actions described in the spec have been implemented and have passing tests.

I used the following gems to help with testing: Rspec, Faker, FactoryBot, Shoulda Matchers, DatabaseCleaner, Pry. I also used the Annotate gem to make the model files more self-documenting.

It was clear from the spec that different user actions were required for trainers and trainees. Although user authentication was not an explicit requirement, I used the Devise gem, so that I could implement effective user authorization.

The user authorization requirement also impacted my namespacing of the action routes, so that it is clear to an API consumer which actions are suitable for each user type. Trainer endpoints are found at `api/v1/trainers/` and trainee endpoints are found at `api/v1/trainees/`.

I used the jbuilder to build the JSON responses. Most models have a `to_builder` method, which created a simple internal API for building nested JSON objects for responses.

I also made efforts to implement good error handling, which is reflected in the tests.


### Challenges

I had not used devise_token_auth or jbuilder before. I'm more used to working with JWT and GraphQL, but I thought it would be nice to try something new. Using these new libraries and having to read new documentation slowed me down a bit.

There was some ambiguity in the spec, for example in the following lines of the spec:
  - **"Each trainee wears a fitness bracelet that provides the medium value of pulse after each exercise is finished."** - There are no actions which explicitly require this data to be shown.
  - **"in order to follow [the trainee's] progress, the trainer has access to their results and can check it for a certain period."** - There are no actions which explicitly require this data to be shown.

I didn't fully grasp the impact of the spec's ambiguity on the project until the later stages of the build, and to be honest, I should have asked for some clarification. I decided against asking writing an email to you on Saturday evening haha, but in a real world environment, I would have asked a team member for some clarification about what is actually required.

Due to the ambiguity, I did not implement the above elements of the spec, although I "create the endpoints that will handle the required actions as they are enumerated below", as explicitly required by the spec.

I'm looking forward to discussing my approach further on a call with you!


## Notes

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
