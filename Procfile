web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
web: bundle exec puma -C config/puma.rb
resque: env TERM_CHILD=1 bundle exec rake resque:work QUEUE='*'
resque: env TERM_CHILD=2 bundle exec rake resque:scheduler LOGFILE=./log/resque_scheduler.log
worker: bundle exec resque-web -p 8081