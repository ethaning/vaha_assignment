require 'rails_helper'

RSpec.describe Trainers::WorkoutsController, type: :request do
  let(:trainer) { create :trainer }
  let(:trainee) { create :trainee }
  let(:workout) { create :workout }

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

      it_behaves_like "unauthorized_action"
    end

    context "when current user is not signed in" do
      subject { get trainers_workout_path(workout), headers: json_headers, as: :json }

      it_behaves_like "unauthorized_user"
    end
  end

  describe "POST #create" do
    let(:workout) { build :workout }
    let(:exercises) { create_list :exercise, 2 }
    let(:params) do
      {
        workout: {
          name: workout.name,
          exercise_ids: exercises.map(&:id),
        }
      }
    end

    subject { post trainers_workouts_path, params: params, headers: create_auth_headers(current_user), as: :json }

    context "when current user is a trainer" do
      let(:current_user) { trainer }

      context "with valid params" do
        it "creates a new workout" do
          subject

          res = json_response
          expect(res[:name]).to eq workout.name
          expect(res[:duration]).to eq exercises.map(&:duration).sum
          expect(res[:creator][:first_name]).to eq current_user.first_name
          expect(res[:creator][:last_name]).to eq current_user.last_name
          expect(res[:creator][:type]).to eq "Trainer"
          expect(res[:creator][:expertise][:name]).to eq current_user.expertise.name
          expect(res[:exercises].count).to eq exercises.count
          expect(res[:exercises].first[:id]).to eq exercises.first.id
        end
      end

      context "with invalid params" do
        let(:params) { { workout: { name: "something", exercise_ids: ["Invalid value"] }} }

        it "returns an error" do
          subject

          res = json_response
          expect(res[:errors].first).to match("Couldn't find Exercise with")
        end
      end

      context "with missing params" do
        let(:params) { {} }

        it "returns an error" do
          subject

          res = json_response
          expect(res[:errors].first).to match("param is missing or the value is empty: workout")
        end
      end
    end

    context "when current user is a trainee" do
      let(:current_user) { trainee }

      it_behaves_like "unauthorized_action"
    end

    context "when current user is not signed in" do
      subject { post trainers_workouts_path, params: params, headers: json_headers, as: :json }

      it_behaves_like "unauthorized_user"
    end
  end

  describe "PUT #update" do
    let(:workout) { create :workout, :with_exercise, creator: current_user }
    let(:exercises) { create_list :exercise, 2 }
    let(:all_exercises) { workout.exercises.concat(exercises) }
    let(:params) do
      {
        workout: {
          name: workout.name,
          exercise_ids: all_exercises.map(&:id),
        }
      }
    end

    subject { put trainers_workout_path(workout), params: params, headers: create_auth_headers(current_user), as: :json }

    context "when current user is a trainer" do
      let(:current_user) { trainer }

      context "with valid params" do
        context "when current_user created the workout" do
          it "updates the workout" do
            subject

            res = json_response
            expect(res[:name]).to eq workout.name
            expect(res[:duration]).to eq all_exercises.map(&:duration).sum
            expect(res[:creator][:first_name]).to eq current_user.first_name
            expect(res[:creator][:last_name]).to eq current_user.last_name
            expect(res[:creator][:type]).to eq "Trainer"
            expect(res[:creator][:expertise][:name]).to eq current_user.expertise.name
            expect(res[:exercises].count).to eq all_exercises.count
            expect(res[:exercises].first[:id]).to eq all_exercises.first.id
            expect(res[:exercises].last[:id]).to eq all_exercises.last.id
          end

        end

        context "when current_user did not create the workout" do
          let(:workout) { create :workout, :with_exercise }

          it_behaves_like "unauthorized_action"
        end
      end

      context "with invalid params" do
        let(:params) { { workout: { name: "something", exercise_ids: ["Invalid value"] }} }

        it "returns an error" do
          subject

          res = json_response
          expect(res[:errors].first).to match("Couldn't find Exercise with")
        end
      end

      context "with missing params" do
        let(:params) { {} }

        it "returns an error" do
          subject

          res = json_response
          expect(res[:errors].first).to match("param is missing or the value is empty: workout")
        end
      end
    end
  end
end
