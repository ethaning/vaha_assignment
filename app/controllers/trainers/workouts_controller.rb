module Trainers
  class WorkoutsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_trainer!
    before_action :find_workout, only: :show

    # Returns a workout object on success
    def show
    end

    # Request params should look like:
    # {
    #   workout: {
    #     name: :required,
    #     exercise_ids: :optional
    #   }
    # }
    #
    # Returns a workout object on success
    #
    def create
      # attrs = { creator: current_user }.merge create_workout_params
      workout = Workout.create!(
        creator: current_user,
        name: create_workout_params[:name],
      )

      if create_workout_params[:exercise_ids].any?
        workout.exercise_ids = create_workout_params[:exercise_ids]
        workout.save!
      end

      @workout = workout
    end

    def update
    end

    def destroy
    end

    def assign
    end

    private

    def find_workout
      @workout = Workout.find(params[:id])
    end

    def create_workout_params
      params.require(:workout).permit(:name, exercise_ids: [])
    end
  end
end
