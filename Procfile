web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
web: bundle exec puma -C config/puma.rb
resque: env QUEUE=* TERM_CHILD=1 RESQUE_TERM_TIMEOUT=7 bundle exec rake resque:work
resque: env QUEUE=* rake resque:scheduler 