module Trainees
  class TrainersController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_trainee!

    # Request params:
    # {
    #   expertise_id: optional,
    # }
    #
    # Returns array of trainers, filtered by an optional expertise, on success
    #
    def index
      expertise = params[:expertise_id] && Expertise.find(params[:expertise_id])
      @trainers = Trainer.by_expertise(expertise)
    end


    # Request params:
    # {
    #   trainer_id: required,
    # }
    #
    # Returns given trainers, on success
    #
    def select
    end
  end
end
