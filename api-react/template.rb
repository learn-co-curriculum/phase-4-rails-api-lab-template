# frozen_string_literal: true

BASE_URI = path.gsub "/api-react/template.rb", ""

### Remove files

# Don't specify a Ruby version, so the lab will work for as many students as
# possible
remove_file '.ruby-version'

# used for js code
remove_dir 'app/javascript'

# used for adding vendor-specific code, typically for the asset pipeline
remove_dir 'vendor'

### Gemfile changes

# Don't specify a Ruby version, so the lab will work for as many students as
# possible
gsub_file 'Gemfile', /^ruby\s+['"].*['"]$/, ''

# Add foreman gem
gem_group :development do
  # run multiple servers (React and Rails)
  gem "foreman", "~> 0.87.2"
end

# Add rspec-rails gem
gem_group :development, :test do
  gem 'rspec-rails', '~> 5.0.0'
end

# Add shoulda-matchers and rspec-json_expectations gems
gem_group :test do
  gem 'rspec-json_expectations'
  gem 'shoulda-matchers', '~> 4.0'
end

# bundle
run 'bundle install'

### Session/cookie middleware
insert_into_file 'config/application.rb', after: 'config.api_only = true' do
  <<-RUBY
    \n
    # Adding back cookies and session middleware
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore

    # Use SameSite=Strict for all cookies to help protect against CSRF
    # https://owasp.org/www-community/SameSite
    config.action_dispatch.cookies_same_site_protection = :strict
  RUBY
end

inside 'app/controllers' do
  class_definition = 'class ApplicationController < ActionController::API'

  inject_into_file "application_controller.rb", after: class_definition do
    "\n  include ActionController::Cookies\n"
  end
end

### Foreman configuration
get "#{BASE_URI}/api-react/files/Procfile.dev", 'Procfile.dev'
get "#{BASE_URI}/api-react/files/start.rake", 'lib/tasks/start.rake'

### RSpec Setup
run 'rails generate rspec:install'

append_to_file '.rspec', '--format documentation'

# Add shoulda-matchers to config
append_to_file 'spec/rails_helper.rb' do
  <<~RUBY

    Shoulda::Matchers.configure do |config|
      config.integrate do |with|
        with.test_framework :rspec
        with.library :rails
      end
    end
  RUBY
end

# Require json_expectations
prepend_to_file 'spec/spec_helper.rb', "require 'rspec/json_expectations'\n"

### Lab Files
remove_file 'README.md'

get "#{BASE_URI}/shared/README.md", 'README.md'
get "#{BASE_URI}/shared/LICENSE.md", 'LICENSE.md'
get "#{BASE_URI}/shared/CONTRIBUTING.md", 'CONTRIBUTING.md'

### Generate React application
run 'npx create-react-app client --use-npm'

insert_into_file 'client/package.json', after: '"private": true,' do
  "\n  \"proxy\": \"http://localhost:3000\",\n"
end
