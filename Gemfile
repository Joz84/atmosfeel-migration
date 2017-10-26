ruby '2.3.4'

source 'https://rubygems.org'
source 'https://rails-assets.org'

# gem 'mysql'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
#gem 'rails', '4.1.8'
gem 'rails', '4.2.0.rc2'
# Use mysql as the database for Active Record
 gem 'mysql2', '~> 0.3.18'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use bourbon to enhance production of stylesheets
gem 'bourbon', '~> 3.1.8'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Routes translations
gem 'route_translator'

# Use AngularJS to add some magic
gem 'rails-assets-angular', '~> 1.3.8'
# AngularJS Sanitize
gem 'rails-assets-angular-sanitize'
# Select2
gem 'rails-assets-angular-ui-select', '~> 0.9.6'
# Wysiwyg for angular
# gem 'rails-assets-angular-wysiwyg' seems to be bugged when minified, so I use local version

# Add CSRF support for AngularJS
gem 'ng-rails-csrf'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# templating system
gem 'slim'
# Foreigner introduces a few methods to your migrations for adding and removing foreign key constraints
#gem 'foreigner'
# Auth system
gem 'devise'
gem "simple_token_authentication"

# Upload
gem 'carrierwave', '0.11.2' #, github: 'carrierwaveuploader/carrierwave'
gem 'mini_magick'

# Assets
gem 'rails-assets-bootstrap'
gem 'rails-assets-jquery-ujs'

# Monitoring
gem 'newrelic_rpm'

# Clone model, lazy way
gem 'deep_cloneable'

group :production do
  gem 'unicorn'
end
# Cron job
gem 'whenever'

# Pagination
gem 'kaminari'

# Elastic search integration
# Must be integrated after the pagination gem: http://is.gd/duKDbh
gem 'elasticsearch-model'
gem 'elasticsearch-rails'

# Paypal
gem 'paypal-sdk-rest'

# Background worker
gem 'sidekiq'

# Monitoring
gem 'sinatra', require: nil

# Replacement for URI implementation
gem 'addressable', require: 'addressable/uri'

# Sanitize html
gem 'sanitize'

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Tools for slim with rails
  gem 'slim-rails'
  # Easings
  gem 'guard-livereload'
  gem 'rack-livereload'
  gem 'guard-rails'
  gem 'guard-bundler'
  gem 'guard-minitest'
  gem 'guard-sidekiq'
  # Better debugging
  gem 'web-console', '~> 2.0'
  gem 'pry-rails'
  # Use Capistrano for deployment
  gem 'capistrano', '3.3.5'
  gem 'capistrano-rails'
  gem 'capistrano-unicorn-nginx', github: 'Awea/capistrano-unicorn-nginx'
  gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano-secrets-yml'
  gem 'capistrano-rails-console'
  gem 'capistrano-sidekiq'
  # faster development server and asset serving
  gem 'rails-dev-tweaks'
  gem 'thin'
  # Procfile-based application
  gem 'foreman'
end

gem 'dotenv-rails', groups: [:development, :test]

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
gem 'figaro'

gem 'rails_12factor'

gem 'rails-i18n', '~> 4.0.0'

gem 'cloudinary'

gem 'mime-types', require: 'mime/types/full'

# gem 'carrierwave-audio'
