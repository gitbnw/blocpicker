# Quota

A stock and portfolio watcher with price alerts via email.

## Installation

Uses rails, redis, resque, and even some gems that don't with r.


## Usage
Start Redis
sudo service redis-server start

Start Resque Web
resque-web

Start Job Scheduler with a log file
rake resque:scheduler LOGFILE=./log/resque_scheduler.log

Start Job Queue
rake resque:work QUEUE='*'

(for Cloud9 Dev enviro start:  rails s webrick -b $IP -p $PORT )

Sign up.  Sign in.  Add Portfolio.  Add stocks.  Watch 'em.  Trade 'em?

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D


