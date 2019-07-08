# frozen_string_literal: true

Rails.application.routes.draw do
  get 'dashboard/status', defaults: {format: :json}
  root to: 'dashboard#index'

  resources :tasks do
    member do
      get 'change_status'
    end
  end
  resources :projects

  # Devise routers
  devise_for :users
end
