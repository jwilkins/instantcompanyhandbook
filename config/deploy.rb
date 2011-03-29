
set :stages, %w(production)
set :default_stage, "production"
require "capistrano/ext/multistage"

set :application, "instantcompanyhandbook.com"

set :user, "applicake"

set :scm, :git
set :repository, "git@github.com:applicake/instantcompanyhandbook.git"
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache

set :default_shell, "/bin/bash --login"
#set :scm_username, ENV["APLLICAKE_DEPLOY_BOT_USERNAME"]
#set :scm_password, ENV["APPLICAKE_DEPLOY_BOT_PASSWORD"]


# bundler settings, overridden in stage specific scripts
require "bundler/capistrano"
#set :bundle_without, [:development, :test, :deployment]

namespace :deploy do
  
#  desc "Starts the thin servers"
#  task :start do
#    run "touch #{release_path}/restart.txt"
#  end
  
  desc "Restart passenger"
  task :restart do
    run "touch #{release_path}/restart.txt"
  end
  
  #desc "Stops the thin servers"
  #task :stop do
  #  run "BUNDLE_GEMFILE=\"#{release_path}/Gemfile\" bundle exec thin -C #{release_path}/config/thin/#{stage}.yml restart"
  #end
  
end
