

  # Change to match your CPU core count
  workers 1
  
  # Min and Max threads per worker
  threads 1, 6
  
  # Default to production
  rails_env = ENV['RAILS_ENV']
  environment rails_env
  
  # Logging
  stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true
  
  
  on_worker_boot do
    require "active_record"
    ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
    ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
  end
