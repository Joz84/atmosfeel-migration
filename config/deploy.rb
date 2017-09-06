# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'atmosfeel'
set :repo_url, 'git@bitbucket.org:Laurent_AtmF/atmosfeel.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
set :branch, 'master'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/atmosfeel'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push(
  'config/database.yml', 'config/paypal.yml', 'config/payplug_credentials.yml', 'config/payplug_config.yml',
  'config/payplug_urls.yml.erb', 'config/paypal_urls.yml.erb', 'config/newrelic.yml'
)

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/uploads')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  after :published, :clear_cache do
    on roles(:all) do
      within release_path do
        execute :rake, "environment elasticsearch:import:model CLASS='Opus' FORCE=y RAILS_ENV=production"
      end
    end
  end
end

set :rbenv_ruby, '2.3.4'

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
