# app/controllers/customers_controller.rb
class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show update destroy]

  def index
    authorize Customer
    @customers = Customer.all
  end

  def show
    authorize @customer
  end

  def create
    @customer = Customer.new(customer_params)
    @customer.created_by = current_user
    authorize @customer
    unless @customer.save
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @customer
    @customer.last_updated_by = current_user
    unless @customer.update(customer_params)
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @customer
    if @customer.destroy
      render json: {
        status: 200,
        message: I18n.t("customers_controller.destroyed"),
      }, status: :ok
    else
      render json: {
        status: 422,
        errors: @customer.errors.full_messages,
      }, status: :unprocessable_entity
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :surname, :photo)
  end
end
