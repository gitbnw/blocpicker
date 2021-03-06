# Change these
server '104.131.169.224', port: 22, roles: [:web, :app, :db], primary: true

set :repo_url,        'git@github.com:gitbnw/blocpicker.git'
set :application,     'blocpicker'
set :user,            'deploy'
set :puma_threads,    [4, 16]
set :puma_workers,    0

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
# set :linked_files, %w{config/database.yml}
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :redis do

    desc "Flushes all Redis data"
    task :flushall do
      on roles(:app) do
        run "redis-cli flushall"
      end
    end

    desc "Restart Redis"
    task :restart do
      on roles(:app), :max_hosts => 1 do
        sudo "/etc/init.d/redis-server stop; sudo /etc/init.d/redis-server start"
      end
    end
    

end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end
  
  desc "Export Upstart script"
  task :export do
    on roles(:app) do
      execute [
        "cd #{release_path} &&",
        'export rvmsudo_secure_path=0 && ',
        "#{fetch(:rvm_path)}/bin/rvm #{fetch(:rvm_ruby_version)} do",
        'rvmsudo',
        'bundle exec foreman export upstart /etc/init -a blocpicker -u deploy -f ./Procfile' 
      ].join(' ')
    end
  end

  desc "Export Upstart script"
  task :services do
    on roles(:app) do
      execute "sudo service blocpicker-worker-1 restart"
      execute "sudo service blocpicker-scheduler-1 restart"
    end
  end
  
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end
  
  desc "reload the database with seed data"
  task :seed do
    on roles(:app) do
      execute [
        "cd #{release_path} &&",
        'export rvmsudo_secure_path=0 && ',
        "#{fetch(:rvm_path)}/bin/rvm #{fetch(:rvm_ruby_version)} do",
        'rvmsudo',
        'bundle exec rake db:seed RAILS_ENV="production"' 
      ].join(' ')      
    end
  end
  
  before :starting,     :check_revision
  before :finishing,    :export
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :services
  after  :finishing,    :restart
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma