require 'rails_helper'

RSpec.describe Trainees::TrainersController, type: :request do
  let(:trainee) { create :trainee }
  let(:trainer_count) { 3 }
  let!(:trainers) do
    trainers = create_list :trainer, trainer_count
  end
  let(:params) { {} }

  describe "GET #index" do
    subject { get trainees_trainers_path(params), headers: create_auth_headers(current_user), as: :json }

    context "when current user is a trainee" do
      let(:current_user) { trainee }

      it "returns the available trainers" do
        subject

        expect(response).to have_http_status(:ok)

        res = json_response
        expect(res.count).to eq trainer_count
        expect(res.first["id"]).to eq trainers.first.id
        expect(res.first["email"]).to eq trainers.first.email
        expect(res.last["id"]).to eq trainers.last.id
        expect(res.last["email"]).to eq trainers.last.email
      end

      context "when an expertise_id param is provided" do
        let(:params) { { expertise_id: expertise_id } }

        context "when valid" do
          let(:expertise_id) { trainers[1].expertise.id }

          it "returns the available trainers" do
            subject

            expect(response).to have_http_status(:ok)

            res = json_response
            expect(res.count).to eq 1
            expect(res.first["id"]).to eq trainers[1].id
            expect(res.first["email"]).to eq trainers[1].email
          end
        end

        context "when invalid" do
          let(:expertise_id) { "Invalid value" }

          it "returns an error" do
            subject

            res = json_response
            expect(res["errors"].first).to match("Couldn't find Expertise with")
          end
        end
      end
    end
  end
end
