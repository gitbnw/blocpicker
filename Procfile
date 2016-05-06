web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
web: bundle exec puma -C config/puma.rb
web: bundle exec resque-web -p 8081
worker: bundle exec rake resque:work QUEUE='*'
worker: bundle exec rake resque:scheduler LOGFILE=./log/resque_scheduler.log

