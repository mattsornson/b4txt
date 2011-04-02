# RVM Bootstrap
$:.unshift(File.expand_path("~/.rvm/lib"))
require 'rvm/capistrano'
set :rvm_ruby_string, '1.8.7-p334'
set :rvm_type, :system

# bundler bootstrap
require 'bundler/capistrano'

# main details
set :application, "dudewheresmybeer.me"
role :web, "dudewheresmybeer.me"
role :app, "dudewheresmybeer.me"
role :db,  "dudewheresmybeer.me", :primary => true

# server details
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_to, "/var/www/beerfortextbooks"
set :deploy_via, :remote_cache
set :user, "ubuntu"
set :use_sudo, false

# repo details
set :scm, :git
#set :scm_username, ""
set :repository, "git@github.com:djhopper01/b4txt.git"
set :branch, "master"
set :git_enable_submodules, 1

# tasks
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Symlink shared resources on each release - not used"
  task :symlink_shared, :roles => :app do
    #run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'
