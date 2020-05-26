# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# Load the SCM plugin appropriate to your project:
#
# require 'capistrano/scm/hg'
# install_plugin Capistrano::SCM::Hg
# or
# require 'capistrano/scm/svn'
# install_plugin Capistrano::SCM::Svn
# or
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

# require 'capistrano/rails'
# require 'capistrano/rvm'
# require 'capistrano/bundler'
# require 'capistrano/sidekiq'
# require 'capistrano/puma'

require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/passenger'
require 'capistrano/sidekiq'
require 'capistrano/puma'

install_plugin Capistrano::Puma  # Default puma tasks
# install_plugin Capistrano::Puma::Nginx  # if you want to upload a nginx site template

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
