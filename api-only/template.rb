# frozen_string_literal: true

BASE_URI = path.gsub "/api-only/template.rb", ""

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

# bundle
run 'bundle install'

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

### Lab Files
remove_file 'README.md'

get "#{BASE_URI}/shared/README.md", 'README.md'
get "#{BASE_URI}/shared/LICENSE.md", 'LICENSE.md'
get "#{BASE_URI}/shared/CONTRIBUTING.md", 'CONTRIBUTING.md'
