# Blocpicker

Stock watcher.  HTML5 graphics, anayltics.

## Installation

TODO: Describe the installation process

## Usage
Start Redis
sudo service redis-server start

Start Resque Web
resque-web

Start Job Scheduler with a log file
rake resque:scheduler LOGFILE=./log/resque_scheduler.log

Start Job Queue
rake resque:work QUEUE='*'

Sign up.  Sign in.  Add Portfolio.  Add stocks.  Watch 'em.  Trade 'em?

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

TODO: Write history

## Credits

TODO: Write credits

## License

TODO: Write license
