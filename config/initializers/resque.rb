require 'resque/scheduler'

# rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
# rails_env = ENV['RAILS_ENV'] || 'development'

# resque_config = YAML.load_file(rails_root + '/config/resque.yml')

uri = ENV["REDISTOGO_URL"] || "redis://localhost:6379/"
Resque.redis = Redis.new(:url => uri)

Resque.redis.namespace = "resque:Rails"

# The schedule doesn't need to be stored in a YAML, it just needs to
# be a hash.  YAML is usually the easiest.
Resque.schedule = YAML.load_file(Rails.root.join('config', 'resque_schedule.yml'))

# If you want to be able to dynamically change the schedule,
# uncomment this line.  A dynamic schedule can be updated via the
# Resque::Scheduler.set_schedule (and remove_schedule) methods.
# When dynamic is set to true, the scheduler process looks for
# schedule changes and applies them on the fly.
# Note: This feature is only available in >=2.0.0.
#Resque::Scheduler.dynamic = true

Dir["#{Rails.root}/app/workers/*.rb"].each { |file| require file }

log_path = File.join Rails.root, 'log'

config = {
  folder:     log_path,                 # destination folder
  class_name: Logger,                   # logger class name
  class_args: [ 'daily', 1.kilobyte ],  # logger additional parameters
  level:      Logger::INFO,             # optional
  formatter:  Logger::Formatter.new,    # optional
}

Resque.logger_config = config