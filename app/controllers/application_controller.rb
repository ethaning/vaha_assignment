class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ErrorResponses

  private

  def authorize_trainer!
    render json: unauthorized_error, status: 401 unless current_user&.trainer?
  end
end
