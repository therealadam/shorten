load 'deploy' if respond_to?(:namespace) # cap2 differentiator
 
set :application, "shortener"
set :domain,      "shortener.railsmachina.com"
set :deploy_to,   "/var/www/apps/#{application}"

set :scm, :git
set :repository, "git://github.com/therealadam/shorten.git"

server domain, :web, :app
 
# Specific to Rails Machine
set :app_server, :passenger
set :user, "deploy"
set :runner, user
set :admin_runner, user
default_run_options[:pty] = true
 
namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
