module Trainers
  class WorkoutsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_workout, only: :show

    def create
    end

    def show
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
  end
end
