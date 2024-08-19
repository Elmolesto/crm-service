# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(current_user, _opts = {})
    if current_user.persisted?
      render json: {
        status: 200,
        message: I18n.t("devise.sessions.signed_in"),
        data: { user: current_user.as_json(only: %i[id email admin]) },
      }, status: :ok
    else
      render json: {
        status: 401,
        message: I18n.t("devise.failure.unauthenticated"),
      }, status: :unauthorized
    end
  end

  def respond_to_on_destroy
    if request.headers["Authorization"].present?
      jwt_payload = JWT.decode(request.headers["Authorization"].split.last,
                               Rails.application.credentials.devise_jwt_secret_key!).first
      current_user = User.find(jwt_payload["sub"])
    end

    if current_user
      render json: {
        status: 200,
        message: I18n.t("devise.sessions.signed_out"),
      }, status: :ok
    else
      render json: {
        status: 401,
        message: I18n.t("devise.failure.not_found_in_database"),
      }, status: :unauthorized
    end
  end
end
