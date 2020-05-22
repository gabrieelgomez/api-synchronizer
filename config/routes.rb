# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'

  post 'api/webhook/orders/created', to: 'webhook#created_order'
  mount Sidekiq::Web => '/sidekiq'
end
