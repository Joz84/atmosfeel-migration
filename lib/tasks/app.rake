desc "create an admin (see .env for credentials)"
task :admin => [:environment] do
  Admin.create(email: ENV['ADMIN_EMAIL'], password: ENV['ADMIN_PWD'])
end

namespace :payplug do
  desc "generates payplug config file for actual environment"
  task :config => [:environment] do
    PayplugConfig.get_configuration
  end
end