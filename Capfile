require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/git_copy"
# install_plugin Capistrano::SCM::Git
install_plugin Capistrano::GitCopy::SCM
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano3/unicorn'

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }

