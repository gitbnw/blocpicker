worker:  RAILS_ENV=production bundle exec rake resque:work QUEUE='*'
scheduler: RAILS_ENV=production bundle exec rake resque:scheduler
rweb: resque-web -p 8081