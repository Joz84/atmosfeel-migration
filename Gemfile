ruby '2.3.4'

source 'https://rubygems.org'
source 'https://rails-assets.org'

# gem 'mysql'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
#gem 'rails', '4.1.8'
# gem 'rails', '4.2.0.rc2'
gem 'rails', '4.2.5.1'
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
gem 'rails-assets-bootstrap', '3.3.2'
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


#######################################
# Fetching git://github.com/Awea/capistrano-unicorn-nginx.git
# Fetching gem metadata from https://rails-assets.org/...
# Fetching gem metadata from https://rubygems.org/..........
# Fetching gem metadata from https://rails-assets.org/..
# Fetching gem metadata from https://rubygems.org/..
# Resolving dependencies.................
# Using rake 12.3.0 (was 12.0.0)
# Using concurrent-ruby 1.0.5
# Using i18n 0.9.5 (was 0.8.0.beta1)
# Using json 1.8.6
# Using minitest 5.11.3 (was 5.10.3)
# Using thread_safe 0.3.6
# Using tzinfo 1.2.5 (was 1.2.3)
# Fetching activesupport 4.2.5.1 (was 4.2.0.rc2)
# Installing activesupport 4.2.5.1 (was 4.2.0.rc2)
# Using builder 3.2.3
# Using erubis 2.7.0
# Using mini_portile2 2.3.0 (was 2.2.0)
# Using nokogiri 1.8.2 (was 1.8.0)
# Using rails-deprecated_sanitizer 1.0.3
# Fetching rails-dom-testing 1.0.9 (was 1.0.8)
# Installing rails-dom-testing 1.0.9 (was 1.0.8)
# Using crass 1.0.3 (was 1.0.2)
# Using loofah 2.2.0 (was 2.0.3)
# Using rails-html-sanitizer 1.0.3
# Fetching actionview 4.2.5.1 (was 4.2.0.rc2)
# Installing actionview 4.2.5.1 (was 4.2.0.rc2)
# Fetching rack 1.6.9 (was 1.6.8)
# Installing rack 1.6.9 (was 1.6.8)
# Using rack-test 0.6.3
# Fetching actionpack 4.2.5.1 (was 4.2.0.rc2)
# Installing actionpack 4.2.5.1 (was 4.2.0.rc2)
# Using globalid 0.4.1 (was 0.3.7)
# Fetching activejob 4.2.5.1 (was 4.2.0.rc2)
# Installing activejob 4.2.5.1 (was 4.2.0.rc2)
# Using mini_mime 1.0.0
# Using mail 2.7.0 (was 2.6.6)
# Fetching actionmailer 4.2.5.1 (was 4.2.0.rc2)
# Installing actionmailer 4.2.5.1 (was 4.2.0.rc2)
# Fetching activemodel 4.2.5.1 (was 4.2.0.rc2)
# Installing activemodel 4.2.5.1 (was 4.2.0.rc2)
# Using arel 6.0.4
# Fetching activerecord 4.2.5.1 (was 4.2.0.rc2)
# Installing activerecord 4.2.5.1 (was 4.2.0.rc2)
# Using public_suffix 3.0.2 (was 3.0.0)
# Using addressable 2.5.2
# Using aws_cf_signer 0.1.3
# Using bcrypt 3.1.11
# Using debug_inspector 0.0.3
# Fetching binding_of_caller 0.8.0 (was 0.7.2)
# Installing binding_of_caller 0.8.0 (was 0.7.2) with native extensions
# Using sass 3.2.19
# Using thor 0.19.4
# Using bourbon 3.1.8
# Using bundler 1.16.1
# Using capistrano-stats 1.1.1
# Using net-ssh 4.2.0
# Using net-scp 1.2.1
# Fetching sshkit 1.16.0 (was 1.14.0)
# Installing sshkit 1.16.0 (was 1.14.0)
# Using capistrano 3.3.5
# Fetching capistrano-bundler 1.3.0 (was 1.2.0)
# Installing capistrano-bundler 1.3.0 (was 1.2.0)
# Fetching capistrano-rails 1.3.1 (was 1.3.0)
# Installing capistrano-rails 1.3.1 (was 1.3.0)
# Using capistrano-rails-console 1.0.2
# Fetching capistrano-rbenv 2.1.3 (was 2.1.1)
# Installing capistrano-rbenv 2.1.3 (was 2.1.1)
# Using capistrano-secrets-yml 1.0.0
# Using connection_pool 2.2.1
# Fetching rack-protection 1.5.5 (was 1.5.3)
# Installing rack-protection 1.5.5 (was 1.5.3)
# Using redis 4.0.1 (was 3.3.3)
# Fetching sidekiq 5.1.1 (was 5.0.4)
# Installing sidekiq 5.1.1 (was 5.0.4)
# Using capistrano-sidekiq 0.10.0
# Using capistrano-unicorn-nginx 3.3.2 from git://github.com/Awea/capistrano-unicorn-nginx.git (at master@709980e)
# Using mime-types-data 3.2016.0521
# Using mime-types 3.1
# Using mimemagic 0.3.2
# Using carrierwave 0.11.2
# Using chronic 0.10.2
# Fetching unf_ext 0.0.7.5 (was 0.0.7.4)
# Installing unf_ext 0.0.7.5 (was 0.0.7.4) with native extensions
# Using unf 0.1.4
# Using domain_name 0.5.20170404
# Using http-cookie 1.0.3
# Using netrc 0.11.0
# Using rest-client 2.0.2
# Fetching cloudinary 1.9.1 (was 1.1.7)
# Installing cloudinary 1.9.1 (was 1.1.7)
# Using coderay 1.1.2
# Using coffee-script-source 1.12.2
# Using execjs 2.7.0
# Using coffee-script 2.4.1
# Fetching railties 4.2.5.1 (was 4.2.0.rc2)
# Installing railties 4.2.5.1 (was 4.2.0.rc2)
# Using coffee-rails 4.0.1
# Fetching daemons 1.2.6 (was 1.2.4)
# Installing daemons 1.2.6 (was 1.2.4)
# Fetching deep_cloneable 2.3.1 (was 2.3.0)
# Installing deep_cloneable 2.3.1 (was 2.3.0)
# Using orm_adapter 0.5.0
# Using responders 2.4.0 (was 2.0.2)
# Using warden 1.2.7
# Using devise 4.4.1 (was 4.3.0)
# Using dotenv 2.2.1
# Using dotenv-rails 2.2.1
# Using multi_json 1.13.1 (was 1.12.2)
# Using elasticsearch-api 5.0.4
# Using multipart-post 2.0.0
# Using faraday 0.14.0 (was 0.13.1)
# Using elasticsearch-transport 5.0.4
# Using elasticsearch 5.0.4
# Using hashie 3.5.7 (was 3.5.6)
# Fetching elasticsearch-model 5.0.2 (was 5.0.1)
# Installing elasticsearch-model 5.0.2 (was 5.0.1)
# Fetching elasticsearch-rails 5.0.2 (was 5.0.1)
# Installing elasticsearch-rails 5.0.2 (was 5.0.1)
# Using eventmachine 1.2.5
# Using http_parser.rb 0.6.0
# Using em-websocket 0.5.1
# Using ffi 1.9.23 (was 1.9.18)
# Using figaro 1.1.1
# Using foreman 0.84.0
# Using formatador 0.2.5
# Fetching rb-fsevent 0.10.3 (was 0.10.2)
# Installing rb-fsevent 0.10.3 (was 0.10.2)
# Using rb-inotify 0.9.10
# Using ruby_dep 1.5.0
# Using listen 3.1.5
# Using lumberjack 1.0.12
# Using nenv 0.3.0
# Using shellany 0.0.1
# Using notiffany 0.1.1
# Using method_source 0.9.0 (was 0.8.2)
# Using pry 0.11.3 (was 0.10.4)
# Fetching guard 2.14.2 (was 2.14.1)
# Installing guard 2.14.2 (was 2.14.1)
# Using guard-compat 1.2.1
# Using guard-bundler 2.1.0
# Using guard-livereload 2.5.2
# Using guard-minitest 2.4.6
# Using guard-rails 0.8.1
# Using guard-sidekiq 0.1.0
# Using hike 1.2.3
# Using jbuilder 2.7.0 (was 2.6.4)
# Fetching kaminari-core 1.1.1 (was 1.0.1)
# Installing kaminari-core 1.1.1 (was 1.0.1)
# Fetching kaminari-actionview 1.1.1 (was 1.0.1)
# Installing kaminari-actionview 1.1.1 (was 1.0.1)
# Fetching kaminari-activerecord 1.1.1 (was 1.0.1)
# Installing kaminari-activerecord 1.1.1 (was 1.0.1)
# Fetching kaminari 1.1.1 (was 1.0.1)
# Installing kaminari 1.1.1 (was 1.0.1)
# Fetching kgio 2.11.2 (was 2.11.0)
# Installing kgio 2.11.2 (was 2.11.0) with native extensions
# Using mini_magick 4.8.0
# Using mysql2 0.3.21
# Fetching newrelic_rpm 4.8.0.341 (was 4.4.0.336)
# Installing newrelic_rpm 4.8.0.341 (was 4.4.0.336)
# Using ng-rails-csrf 0.1.0
# Fetching nokogumbo 1.5.0 (was 1.4.13)
# Installing nokogumbo 1.5.0 (was 1.4.13) with native extensions
# Using xml-simple 1.1.5
# Fetching paypal-sdk-rest 1.7.2 (was 1.6.0)
# Installing paypal-sdk-rest 1.7.2 (was 1.6.0)
# Using pry-rails 0.3.6
# Using rack-livereload 0.3.16
# Using tilt 1.4.1
# Using sprockets 2.12.4
# Using sprockets-rails 2.3.3
# Fetching rails 4.2.5.1 (was 4.2.0.rc2)
# Installing rails 4.2.5.1 (was 4.2.0.rc2)
# Using rails-assets-angular 1.3.20
# Using rails-assets-angular-sanitize 1.3.20
# Using rails-assets-angular-ui-select 0.9.9
# Fetching rails-assets-bootstrap 4.0.0 (was 3.3.2)
# Installing rails-assets-bootstrap 4.0.0 (was 3.3.2)
# Fetching rails-assets-jquery 3.3.1 (was 3.2.1)
# Installing rails-assets-jquery 3.3.1 (was 3.2.1)
# Using rails-assets-jquery-ujs 1.2.2
# Using rails-dev-tweaks 1.2.0
# Using rails-i18n 4.0.9
# Using rails_serve_static_assets 0.0.5
# Using rails_stdout_logging 0.0.5
# Using rails_12factor 0.0.3
# Using raindrops 0.19.0
# Using rdoc 4.3.0
# Using route_translator 4.4.1
# Fetching sanitize 4.6.0 (was 4.5.0)
# Installing sanitize 4.6.0 (was 4.5.0)
# Using sass-rails 4.0.5
# Using sdoc 0.4.2
# Using simple_token_authentication 1.15.1
# Using sinatra 1.4.8
# Using temple 0.8.0
# Fetching slim 3.0.9 (was 3.0.8)
# Installing slim 3.0.9 (was 3.0.8)
# Fetching slim-rails 3.1.3 (was 3.1.2)
# Installing slim-rails 3.1.3 (was 3.1.2)
# Using spring 2.0.2 (was 1.7.2)
# Using thin 1.7.2
# Fetching uglifier 4.1.7 (was 3.2.0)
# Installing uglifier 4.1.7 (was 3.2.0)
# Fetching unicorn 5.4.0 (was 5.3.0)
# Installing unicorn 5.4.0 (was 5.3.0) with native extensions
# Using web-console 2.3.0
# Fetching whenever 0.10.0 (was 0.9.7)
# Installing whenever 0.10.0 (was 0.9.7)
# Bundle updated!
# Post-install message from rails-assets-bootstrap:
# This component doesn't define main assets in bower.json.
# Please open new pull request in component's repository:
# https://github.com/twbs/bootstrap



