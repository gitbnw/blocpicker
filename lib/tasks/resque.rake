require 'resque/tasks'
require 'resque/scheduler/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*'
end

task "resque:scheduler" => :environment do
    LOGFILE='./log/resque_scheduler.log'
end
desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" => "resque:work"