set :application, "pinger"

# This only works because both are deployed on the same server
set :domain, 'pinger.neotericdesign.com'
role :web, domain
role :app, domain
role :db,  domain, :primary => true

##
# == Staging environment
#
# From the command line:
#   cap deploy
#
# Default to staging
set :rails_env, :production
set :deploy_to, "/home/ndnet/pinger"

ssh_options[:port] = 7822
default_run_options[:pty] = true

set :user, "ndnet"
set :use_sudo, false

set :scm, :git
set :repository,  "git@github.com:neotericdesign/pinger.git"
set :branch, 'master'
set :git_enable_submodules, 1

set :deploy_via, :remote_cache

desc "Run a Rake task remotely. Set the task with RAKE_TASK='your task here'"
task :rake do
  if ENV["RAKE_TASK"]
    run "cd #{current_path} && rake RAILS_ENV=#{rails_env} #{ENV["RAKE_TASK"]}"
  else
    puts "You need to set a task with RAKE_TASK='task here'"
  end
end

namespace :deploy do
  desc "Tell Passenger to restart the app."
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/settings.yml #{release_path}/config/settings.yml"
    run "ln -nfs #{shared_path}/db/production.sqlite3 #{release_path}/db/production.sqlite3"
  end

  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{current_path} && whenever --update-crontab #{rails_env}"
  end
end

namespace :db do
  desc "Seed the database with configured seedlings"
  task :seed do
    run("cd #{deploy_to}/current; rake db:seed RAILS_ENV=#{rails_env}")
  end
end

after "deploy:symlink", "deploy:update_crontab"
after 'deploy:update_code', 'deploy:symlink_shared'

# Delayed Job callbacks:
# after "deploy:stop",    "delayed_job:stop"
# after "deploy:start",   "delayed_job:start"
# after "deploy:restart", "delayed_job:restart"
