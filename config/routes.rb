# frozen_string_literal: true

Rails.application.routes.draw do
  scope :v1 do
    devise_for :users, controllers: { sessions: "users/sessions" }, defaults: { format: :json }
    resources :users, only: %i[index show create update destroy],
                      defaults: { format: :json } do
      patch :admin_status, on: :member
    end
    resources :customers, only: %i[index show create update destroy],
                          defaults: { format: :json }
  end

  root to: "application#info"
  get "v1", to: "application#info"
end
