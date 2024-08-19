Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }, defaults: { format: :json }
  resources :users, only: [:index, :show, :create, :update, :destroy], defaults: {format: :json} do
    patch :change_admin_status, on: :member
  end
  resources :customers, only: [:index, :show, :create, :update, :destroy], defaults: {format: :json}

  get "up" => "rails/health#show", as: :rails_health_check
end
