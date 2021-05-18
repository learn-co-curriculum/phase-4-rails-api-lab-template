# frozen_string_literal: true

BASE_URI = path.gsub "/template.rb", ""

### React
if yes?("Include React?")
  ### Generate React application
  run 'npx create-react-app client --use-npm'

  inside 'client' do
    insert_into_file 'package.json', after: '"private": true,' do
      "\n  \"proxy\": \"http://localhost:3000\","
    end

    name = app_name.gsub("_", "-")
    gsub_file 'package.json', '"name": "client"', "\"name\": \"#{name}-client\""
    
    gsub_file 'package.json', 'react-scripts start', 'PORT=4000 react-scripts start'
  end
  
  ### Foreman configuration
  gem_group :development do
    gem 'foreman', '~> 0.87'
  end
  create_file 'Procfile.dev' do
    <<~TXT
      web: PORT=4000 npm start --prefix client
      api: PORT=3000 bundle exec rails s
    TXT
  end

  ### Rakefiles
  rakefile "start.rake" do
    <<~TASK
      desc 'Run Rails server and React in development'
      task start: :environment do
        exec 'foreman start -f Procfile.dev'
      end
    TASK
  end
  
  rakefile "install.rake" do
    <<~TASK
      desc 'Install Rails and React dependencies'
      task install: :environment do
        exec 'bundle install'
        exec 'npm instll --prefix client'
      end
    TASK
  end
  
  remove_file 'lib/tasks/.keep'
end

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

# Add rspec-rails gem
gem_group :development, :test do
  gem 'rspec-rails', '~> 5.0.0'
end

# Add shoulda-matchers and rspec-json_expectations gems
gem_group :test do
  gem 'rspec-json_expectations'
  gem 'shoulda-matchers', '~> 4.0'
end

# Bundle
run 'bundle install'

# Add supported platforms to Gemfile.lock
after_bundle do
  run 'bundle lock --add-platform x86_64-linux'
  run 'bundle lock --add-platform ruby'
end

### Session/cookie middleware

# add to config/application.rb
environment do
  <<-RUBY
    # Adding cookies and session middleware
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

### Add Lab Files
remove_file 'README.md'

get "#{BASE_URI}/files/README.md", 'README.md'
get "#{BASE_URI}/files/LICENSE.md", 'LICENSE.md'
get "#{BASE_URI}/files/CONTRIBUTING.md", 'CONTRIBUTING.md'
