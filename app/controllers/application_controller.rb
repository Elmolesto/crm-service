# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit::Authorization
  before_action :authenticate_user!, except: :info

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def info
    render json: {
      status: 200,
      message: "Welcome to the CRM API",
    }, status: :ok
  end

  private

  def user_not_authorized
    render json: {
      status: 403,
      message: I18n.t("pundit.not_authorized"),
    }, status: :forbidden
  end
end
