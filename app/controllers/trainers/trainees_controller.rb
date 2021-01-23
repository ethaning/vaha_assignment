module Trainers
  class TraineesController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_trainer!

    # Returns array of the current_user's trainees on success
    #
    def index
      @trainees = current_user.trainees
    end
  end
end
