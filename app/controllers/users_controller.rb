# frozen_string_literal: true

# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy change_admin_status]

  def index
    authorize User
    @users = User.all
    render json: @users
  end

  def show
    authorize @user
    render json: @user
  end

  def create
    @user = User.new(user_params)
    authorize @user
    if @user.save
      render json: {
        status: 200,
        user: @user,
        message: I18n.t("users_controller.created"),
      }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @user
    if @user.update(user_params)
      render json: {
        status: 200,
        user: @user,
        message: I18n.t("users_controller.updated"),
      }, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @user
    if @user.destroy
      render json: {
        status: 200,
        message: I18n.t("users_controller.destroyed"),
      }, status: :ok
    else
      render json: {
        status: 422,
        errors: @user.errors.full_messages,
      }, status: :unprocessable_entity
    end
  end

  def change_admin_status
    authorize @user, :change_admin_status?
    @user.admin = admin_flag_params[:admin].to_s == "true"

    if @user.save
      render json: {
               status: 200,
               message: I18n.t("users_controller.admin_changed"),
               user: @user,
             },
             status: :ok
    else
      render json: {
        status: 422,
        errors: @user.errors.full_messages,
      }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def admin_flag_params
    params.require(:user).permit(:admin)
  end
end
