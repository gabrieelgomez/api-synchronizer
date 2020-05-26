# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'

  post 'api/webhook/orders/created', to: 'webhook#created_order'
  post 'api/webhook/health_test', to: 'webhook#health_test'

  mount Sidekiq::Web => '/sidekiq'
end
