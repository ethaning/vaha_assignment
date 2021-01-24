require 'rails_helper'

RSpec.describe Trainees::WorkoutSessionsController, type: :request do
  let(:trainee) { create :trainee }
  let(:trainee_workout) { create :trainee_workout, trainee: trainee }
  let(:sessions_count) { 3 }
  let!(:workout_sessions) do
    create_list :workout_session, sessions_count, trainee_workout: trainee_workout
  end
  let(:params) { {} }

  describe "GET #index" do
    subject { get trainees_workout_sessions_path(params), headers: create_auth_headers(current_user), as: :json }

    context "when current user is a trainee" do
      let(:current_user) { trainee }

      it "returns the available workout sessions" do
        subject

        expect(response).to have_http_status(:ok)

        res = json_response
        expect(res.count).to eq sessions_count
        expect(res.first["id"]).to eq workout_sessions.first.id
        expect(res.first["completed_at"]).to eq workout_sessions.first.completed_at.to_json[1...-1]
        expect(res.first["workout"]["id"]).to eq trainee_workout.workout.id
        expect(res.last["id"]).to eq workout_sessions.last.id
        expect(res.last["completed_at"]).to eq workout_sessions.last.completed_at.to_json[1...-1]
        expect(res.last["workout"]["id"]).to eq trainee_workout.workout.id
      end

      context "when an date params are provided" do
        let(:params) { { from_date: from_date, to_date: to_date } }
        let(:old_workout_session) do
          session = workout_sessions[1]
          session.update!(completed_at: 6.months.ago.utc)
          session
        end

        context "when valid" do
          let(:from_date) { 1.month.ago }
          let(:to_date) { 1.month.from_now }

          it "returns the available workout_sessions, scoped by completion date" do
            subject

            expect(response).to have_http_status(:ok)

            res = json_response
            expect(res.count).to eq sessions_count
            expect(res.first["id"]).to eq workout_sessions.first.id
            expect(res.first["completed_at"]).to eq workout_sessions.first.completed_at.to_json[1...-1]
            expect(res.first["workout"]["id"]).to eq trainee_workout.workout.id
            expect(res.last["id"]).to eq workout_sessions.last.id
            expect(res.last["completed_at"]).to eq workout_sessions.last.completed_at.to_json[1...-1]
            expect(res.last["workout"]["id"]).to eq trainee_workout.workout.id
          end
        end

        context "when date range is invalid" do
          let(:from_date) { Time.now.utc }
          let(:to_date) { 1.month.ago }

          it "returns an error" do
            subject

            res = json_response
            expect(res["errors"].first).to match("Date range is invalid")
          end
        end

        context "when only one date boundary is present" do
          let(:from_date) { nil }
          let(:to_date) { 1.month.ago }

          it "returns an error" do
            subject

            res = json_response
            expect(res["errors"].first).to match("Date range is invalid")
          end
        end
      end
    end

    context "when current user is a trainer" do
      let(:trainer) { create :trainer }
      let(:current_user) { trainer }

      it_behaves_like "unauthorized_action"
    end

    context "when current user is not signed in" do
      subject { get trainees_workout_sessions_path(params), headers: json_headers, as: :json }

      it_behaves_like "unauthorized_user"
    end
  end
end
