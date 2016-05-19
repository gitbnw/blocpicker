require 'resque/tasks'
require 'resque/scheduler/tasks'

task "resque:preload" => :environment

# desc "Alias for resque:work (To run workers on Heroku)"
# task "jobs:work" => "resque:work"
