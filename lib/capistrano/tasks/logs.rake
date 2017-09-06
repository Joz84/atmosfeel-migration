namespace :logs do
  desc "tail rails logs" 
  task :rails do
    on roles(:app) do
      execute "tail -f #{shared_path}/log/#{fetch(:rails_env)}.log -f /var/log/nginx/atmosfeel_production.error.log -f #{shared_path}/log/unicorn.stderr.log"
    end
  end

  desc "tail nginx logs"
  task :nginx do
    on roles(:app) do
      execute "sudo tail -f /var/log/nginx/error.log -f /var/log/nginx/access.log"
    end
  end
end
