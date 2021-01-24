Rails.application.routes.draw do
  get 'workout/index'
  scope :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'

      namespace :trainers do
        resources :workouts, except: %i[index] do
          member do
            post :assign
          end
        end
        resources :trainees, only: %i[index]
      end

      namespace :trainees do
        resources :workout_sessions, only: %i[index]
        resources :trainers, only: %i[index] do
          member do
            post :select
          end
        end
      end
    end
  end
end
