class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ErrorResponses

  rescue_from ActiveRecord::RecordNotFound, ActionController::ParameterMissing do |exception|
    render json: raised_error(exception), status: 404
  end

  private

  def authorize_trainer!
    render json: unauthorized_error, status: 401 unless current_user&.trainer?
  end

  def authorize_trainee!
    render json: unauthorized_error, status: 401 unless current_user&.trainee?
  end
end
