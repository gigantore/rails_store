set :application, "store"
set :deploy_to,  "/home/www/alexpearce.me/public/#{application}"

server "46.137.47.196", :app, :web, :db, :primary => true

default_run_options[:ptr] = true # Ensure password prompt is prompt true
set :repository, 'git@46.137.47.196:store.git' # your private/public url and user
set :scm, 'git' # scm utility name
set :branch, 'capistrano' # remote branch
set :deploy_via, :copy # If you have public like github.com then use :remote_cache

set :user, 'root'
set :admin_runner, 'root'

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end