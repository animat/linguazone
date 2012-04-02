set :rails_env, :production
  
before("deploy:restart") { set :use_sudo, false } 
after "deploy:start", :restart_web_server
after :deploy, "deploy:cleanup"

set :user, "animat"
set :application, "beta.linguazone.com"
set :domain, "beta.linguazone.com"
set :repository, "http://linguazone.com/svn/lz-v2/lz/"
set :scm, :subversion
set :scm_username, "colin"
set(:scm_password){Capistrano::CLI.password_prompt("Subversion Password: ")}

set :deploy_to, "/users/home/#{user}/domains/#{domain}/web"

set :use_sudo, false
role :app, domain
role :web, domain
role :db,  domain, :primary => true

default_run_options[:pty] = true

namespace :deploy do
  desc "Restart Mongrel by killing" 
  task :restart, :roles => :app do
    run "pkill mongrel"
  end

  task :start, :roles => :app do
  end

  task :stop, :roles => :app do
  end
end

desc "A Capistrano task that runs a remote rake task."
task :clear_sessions, :roles => :db do
  run "cd #{release_path}; rake db:sessions:clear RAILS_ENV=production"
end
        require './config/boot'
        require 'airbrake/capistrano'
