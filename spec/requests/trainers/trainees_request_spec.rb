require 'rails_helper'

RSpec.describe Trainers::TraineesController, type: :request do
  let(:trainer) { create :trainer }
  let(:trainee_count) { 3 }
  let!(:trainees) do
    trainees = create_list :trainee, trainee_count
    trainees.each { |trainee| TraineeTrainer.create! trainee: trainee, trainer: trainer }
    trainees
  end

  describe "GET #index" do
    subject { get trainers_trainees_path, headers: create_auth_headers(current_user), as: :json }

    context "when current user is a trainer" do
      let(:current_user) { trainer }

      it "returns the current user's trainees" do
        subject

        expect(response).to have_http_status(:ok)

        res = json_response
        expect(res.count).to eq trainee_count
        expect(res.first["id"]).to eq trainees.first.id
        expect(res.first["email"]).to eq trainees.first.email
        expect(res.last["id"]).to eq trainees.last.id
        expect(res.last["email"]).to eq trainees.last.email
      end
    end

    context "when current user is a trainee" do
      let(:trainee) { create :trainee }
      let(:current_user) { trainee }

      it_behaves_like "unauthorized_action"
    end

    context "when current user is not signed in" do
      subject { get trainers_trainees_path, headers: json_headers, as: :json }

      it_behaves_like "unauthorized_user"
    end
  end
end
