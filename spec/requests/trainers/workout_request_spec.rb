require 'rails_helper'

RSpec.describe Trainers::WorkoutsController, type: :request do
  let(:trainer) { create :trainer }
  let(:trainee) { create :trainee }
  let(:workout) { create :workout }
  # let(:params) { {} }

  describe "GET #show" do
    subject { get trainers_workout_path(workout), headers: create_auth_headers(current_user), as: :json }

    context "when current user is a trainer" do
      let(:current_user) { trainer }

      it "shows the given workout" do
        subject

        expect(response).to have_http_status(:ok)

        res = json_response
        expect(res[:name]).to eq workout.name
        expect(res[:duration]).to eq workout.duration
        expect(res[:creator][:first_name]).to eq workout.creator.first_name
        expect(res[:creator][:last_name]).to eq workout.creator.last_name
        expect(res[:creator][:type]).to eq "Trainer"
        expect(res[:creator][:expertise][:name]).to eq workout.creator.expertise.name
      end
    end

    context "when current user is a trainee" do
      let(:current_user) { trainee }

      it "returns an error" do
        subject

        expect(response).to have_http_status(:unauthorized)

        res = json_response
        expect(res[:name]).to be_nil
        expect(res[:errors]).to eq(["You are not authorized to view this resource."])
      end
    end

    context "when current user is not signed in" do
      subject { get trainers_workout_path(workout), headers: json_headers, as: :json }

      it "returns an error" do
        subject

        expect(response).to have_http_status(:unauthorized)

        res = json_response
        expect(res[:name]).to be_nil
        expect(res[:errors]).to eq(["You need to sign in or sign up before continuing."])
      end
    end
  end
end
