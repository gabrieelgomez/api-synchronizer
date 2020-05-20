# frozen_string_literal: true

require 'sidekiq-scheduler'

# Jobs for sync products data
class ApiSynchronizer
  include Sidekiq::Worker

  def perform
    CimoSynchronizer.sync
  end
end
