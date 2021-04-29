# frozen_string_literal: true

### Remove files

# Don't specify a Ruby version, so the lab will work for as many students as possible
remove_file '.ruby-version'

# used for js code
remove_dir 'app/javascript'

# lib/task: used for adding Rake tasks
remove_dir 'lib'

# used for adding vendor-specific code, typically for the asset pipeline
remove_dir 'vendor'

### Gemfile changes

# Don't specify a Ruby version, so the lab will work for as many students as possible
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

# Uncomment rack-cors gem
gsub_file 'Gemfile', /^#\s+gem\s+['"]rack-cors['"]$/, "gem 'rack-cors'"

# bundle
run 'bundle install'

### CORS Configuration

inside 'config/initializers' do
  remove_file 'cors.rb'

  file 'cors.rb' do
    <<~RUBY
      # Be sure to restart your server when you modify this file.

      # Avoid CORS issues when API is called from the frontend app.
      # Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

      # Read more: https://github.com/cyu/rack-cors

      Rails.application.config.middleware.insert_before 0, Rack::Cors do
        allow do
          origins '*'

          resource '*',
                   headers: :any,
                   methods: [:get, :post, :put, :patch, :delete, :options, :head]
        end
      end
    RUBY
  end
end

### RSpec Setup

run 'rails generate rspec:install'

append_to_file '.rspec', '--format documentation'

inside 'spec' do
  # Add shoulda-matchers to config
  append_to_file 'rails_helper.rb' do
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
  prepend_to_file 'spec_helper.rb', "require 'rspec/json_expectations'\n"
end
