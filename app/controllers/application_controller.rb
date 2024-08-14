# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit::Authorization
  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    render json: {
      status: 401,
      message: I18n.t("pundit.not_authorized"),
    }, status: :unauthorized
  end
end
