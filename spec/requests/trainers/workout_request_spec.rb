require 'rails_helper'

RSpec.describe Trainers::WorkoutsController, type: :request do
  let(:trainer) { create :trainer }
  let(:workout) { create :workout }
  let(:params) { {} }

  describe "GET #show" do
    subject { get trainers_workout_path(workout), headers: create_auth_headers(trainer), as: :json }

    context "when current user is a trainer" do
      it "shows the given workout" do
        subject

        res = json_response
        expect(res[:name]).to eq workout.name
        expect(res[:duration]).to eq workout.duration
        expect(res[:creator][:first_name]).to eq workout.creator.first_name
        expect(res[:creator][:last_name]).to eq workout.creator.last_name
        expect(res[:creator][:type]).to eq "Trainer"
        expect(res[:creator][:expertise][:name]).to eq workout.creator.expertise.name
      end
    end
  end
end
