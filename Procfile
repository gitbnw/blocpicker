web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
web: bundle exec puma -C config/puma.rb
resque: env TERM_CHILD=1 QUEUE=* bundle exec rake resque:work