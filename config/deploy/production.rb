server "50.17.136.227", :app

set :branch, "deploy"

namespace :deploy do
  task :symlink_config do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  desc "Migrate database."
  task :migrate do
    run "cd #{release_path} && RAILS_ENV=production rake db:migrate"
  end
end

after 'deploy:update_code', 'deploy:symlink_config',  'deploy:migrate'
