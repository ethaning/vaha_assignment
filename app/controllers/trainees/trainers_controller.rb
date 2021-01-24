module Trainees
  class TrainersController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_trainee!
    before_action :find_trainer, only: :select

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
      @trainee_trainer = TraineeTrainer.create! trainee: current_user, trainer: @trainer
    end

    private

    def find_trainer
      @trainer = Trainer.find(params[:id])
    end
  end
end
