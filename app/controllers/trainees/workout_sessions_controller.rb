module Trainees
  class WorkoutSessionsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_trainee!
    before_action :validate_date_params, only: :index

    # Request params:
    # {
    #   from_date: optional,
    #   to_date: optional,
    # }
    #
    # Returns array of the current_user's workouts filtered by time period on success
    #
    def index
      @sessions = current_user.workout_sessions
      @sessions = @sessions.filtered_at_date(@from_date, @to_date) if @from_date && @to_date
      @sessions
    end

    private

    def validate_date_params
      @from_date = params[:from_date]
      @to_date = params[:to_date]

      return if @from_date.blank? && @to_date.blank?
      return if @from_date.present? && @to_date.present? && @from_date < @to_date

      render json: invalid_date_range_error, status: 422
    end
  end
end
