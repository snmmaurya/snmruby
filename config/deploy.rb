# config valid for current version and patch releases of Capistrano
lock "~> 3.18.1"


set :application, "snmruby"
set :repo_url, "git@github.com:snmmaurya/snmruby.git"# restart app by running: touch tmp/restart.txt
# at server machine
set :branch, 'main'
set :passenger_restart_with_touch, true
set :rails_env, :production
set :puma_threads, [4, 16]
# Don’t change these unless you know what you’re doing
set :pty, true
set :use_sudo, false
set :stage, :production
set :deploy_via, :remote_cache
set :puma_bind, "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log, "#{release_path}/log/puma.access.log"
set :linked_files, %w{config/master.key config/database.yml}
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, false 
set :deploy_to, "/var/www/snmruby"
set :puma_conf, "#{shared_path}/config/puma.rb"
set :puma_service_unit_name, "puma_#{fetch(:application)}_production"


namespace :puma do
  Rake::Task[:restart].clear_actions
  task :restart do
    invoke 'puma:stop'
    invoke 'puma:start'
  end
end