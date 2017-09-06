# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'livereload', host: ENV['LOCAL_HOST'] do
  watch(%r{app/views/.+\.(html|erb|haml|slim)$})
  watch(%r{app/(helpers|controllers)/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|scss|sass|js|html|png|jpg|coffee))).*}) { |m| "/assets/#{m[3]}" }
end

guard :bundler do
  watch('Gemfile')
  # Uncomment next line if your Gemfile contains the `gemspec' command.
  # watch(/^.+\.gemspec/)
end

guard 'rails', host: ENV['LOCAL_HOST'] do
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
end

### Guard::Sidekiq
#  available options:
#  - :verbose
#  - :queue (defaults to "default") can be an array
#  - :concurrency (defaults to 1)
#  - :timeout
#  - :environment (corresponds to RAILS_ENV for the Sidekiq worker)
guard 'sidekiq', :environment => 'development' do
  watch(%r{^app/workers/(.+)\.rb$})
end

guard :minitest do
  # with Minitest::Unit
  watch(%r{^test/(.*)\/?test_(.*)\.rb$})
  watch(%r{^lib/(.*/)?([^/]+)\.rb$})     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r{^test/test_helper\.rb$})      { 'test' }

  # with Minitest::Spec
  # watch(%r{^spec/(.*)_spec\.rb$})
  # watch(%r{^lib/(.+)\.rb$})         { |m| "spec/#{m[1]}_spec.rb" }
  # watch(%r{^spec/spec_helper\.rb$}) { 'spec' }

  # Rails 4
  # watch(%r{^app/(.+)\.rb$})                               { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^app/models/(.+)\.rb})                        { |m| "test/models/#{m[1]}_test.rb" }
  watch(%r{^app/services/(.+)\.rb})                      { |m| "test/services/#{m[1]}_test.rb" }
  watch(%r{^app/presenters/(.+)_presenter\.rb})          { |m| "test/presenters/#{m[1]}_presenter_test.rb" }
  watch(%r{^app/helpers/(.+)_helper\.rb})          { |m| "test/helpers/#{m[1]}_helper_test.rb" }
  watch(%r{^app/controllers/(.+)_controller\.rb})        { |m| "test/controllers/#{m[1]}_controller_test.rb" }
  watch(%r{^app/views/(.+)_mailer/.+})                   { |m| "test/mailers/#{m[1]}_mailer_test.rb" }
  watch(%r{^app/mailers/(.+)_mailer\.rb})                   { |m| "test/mailers/#{m[1]}_mailer_test.rb" }
  watch(%r{^test/.+_test\.rb})

  # Rails < 4
  # watch(%r{^app/controllers/(.*)\.rb$}) { |m| "test/functional/#{m[1]}_test.rb" }
  # watch(%r{^app/helpers/(.*)\.rb$})     { |m| "test/helpers/#{m[1]}_test.rb" }
  # watch(%r{^app/models/(.*)\.rb$})      { |m| "test/unit/#{m[1]}_test.rb" }
end