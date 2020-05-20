# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'

gem 'bootsnap', '>= 1.4.2', require: false

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'

gem 'httparty', '~> 0.18.0'
gem 'sidekiq', '~>6.0.0'
gem 'sidekiq-scheduler'
gem 'woocommerce_api', '~> 1.4'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
