task :export do

    on roles(:app) do
      execute [
        "cd #{release_path} &&",
        'export rvmsudo_secure_path=0 && ',
        "#{fetch(:rvm_path)}/bin/rvm #{fetch(:rvm_ruby_version)} do",
        'rvmsudo',
        'RAILS_ENV=production bundle exec foreman export --app blocpicker --user bnw -l logfile-path -f ./Procfile upstart /etc/init -c worker=1,scheduler=1,web=1'
      ].join(' ')
    end
end


task :restart do 
  on roles(:app) do
    execute :sudo, "restart appname"
  end
end
after :publishing, :export
   after :publishing, :restart