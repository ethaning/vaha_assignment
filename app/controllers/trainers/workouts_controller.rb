module Trainers
  class WorkoutsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_trainer!
    before_action :find_workout, except: :create
    before_action :current_user_is_creator, only: %i[update destroy]

    # Request params:
    # {
    #   id: required,
    # }
    #
    # Returns a workout object on success
    #
    def show
    end

    # Request params:
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
      @workout = Workout.create!(
        creator: current_user,
        name: updatable_workout_params[:name],
      )

      update_workout_exercises
    end

    # Request params:
    # {
    #   id: required,
    #   workout: {
    #     name: :required,
    #     exercise_ids: :optional
    #   }
    # }
    #
    # current_user can only update workouts that they have created.
    #
    # Returns a workout object on success
    #
    def update
      @workout.update!(name: updatable_workout_params[:name])
      update_workout_exercises
    end

    # Request params:
    # {
    #   id: required,
    # }
    #
    # current_user can only update workouts that they have created.
    #
    # Returns { success: true } on success
    #
    def destroy
      @workout.destroy!
    end

    def assign
    end

    private

    def find_workout
      @workout = Workout.find(params[:id])
    end

    def updatable_workout_params
      params.require(:workout).permit(:name, exercise_ids: [])
    end

    def update_workout_exercises
      @workout.exercise_ids = updatable_workout_params[:exercise_ids]
      @workout.save!
    end

    def current_user_is_creator
      render json: unauthorized_error, status: 401 unless current_user == @workout.creator
    end
  end
end
