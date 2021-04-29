# Rails API Lab Template

A [Rails Application Template][] for generating new Rails API labs with
updated dependencies.

## Usage

```sh
rails new <lab-name> -BT --api --minimal -m=./rails-lab-template/template.rb
```

- `-m` uses the custom Flatiron lab template to provide some additional setup.
- `-B` skips bundle install, since we'll want to make some changes before bundling.
- `-T` skips test files, since we'll be using `rspec`.
- `--api` configures the app with a limited set of middleware, and skips
  views/helpers/assets on resource generation.
- `--minimal` excludes the following:
  - `action_cable`
  - `action_mailbox`
  - `action_mailer`
  - `action_text`
  - `active_job`
  - `active_storage`
  - `bootsnap`
  - `jbuilder`
  - `spring`
  - `system_tests`
  - `turbolinks`
  - `webpack`

We can also delete:

- `app/javascript`
- `lib/tasks` (used for adding Rake tasks)
- `vendor` (used for adding vendor-specific code, typically for the asset
  pipeline)

## Writing Tests

It's recommended to use Rails generators to add new code, since `rspec` will
give you a template for models and controllers (requests) automatically when
you use `rails g`.

In addition to `rspec-rails`, these gems provide some additional matchers:

- `rspec-json_expectations` gives a [`include_json` matcher](https://relishapp.com/waterlink/rspec-json-expectations/docs/json-expectations)
- `shoulda-matchers` gives [a bunch of model/controller matchers](https://github.com/thoughtbot/shoulda-matchers#matchers)

## Template Notes

The `template.rb` file takes care of a few extra things, documented below:

### Remove Ruby Version

Since we don't want to update the labs every time a new Ruby version is
released, and want them to work for as many versions of Ruby as possible, we
need to remove references to the Ruby version in the project:

- Delete the `.ruby-version` file
- Remove the Ruby version at the top of the Gemfile

### Setup RSPec

- Add [`rspec-rails`](https://github.com/rspec/rspec-rails) gem to the development and test groups
- Add [`shoulda-matchers`](https://github.com/thoughtbot/shoulda-matchers) gem to test group
- Add [`rspec-json_expectations`](https://github.com/waterlink/rspec-json_expectations) gem to test group
- Run `rails generate rspec:install`

### Setup CORS

Use the [`rack-cors` gem](https://github.com/cyu/rack-cors) by default,
so labs with frontend code will work

- Add `rack-cors` in the Gemfile
- In `config/initializers/cors.rb`:

```rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```

## TODO

- replace path with Github URL
- Gemfile.lock - platform?
- gitignore the Gemfile.lock entirely?
- Test in Windows environment

## Resources

### Templating

- [Rails Docs on Templating][rails application template]
- [Rails Templating Blog](http://www.rutionrails.com/blog/2016/7/8/regarding-rails-templates-1)
- [Thor Actions Wiki](https://github.com/erikhuda/thor/wiki/Actions) and [Docs](https://rdoc.info/github/erikhuda/thor/master/Thor/Actions)

### Testing

- [RSpec API Testing](https://rubyyagi.com/rspec-request-spec/)
- [More RSpec API Testing](https://www.nopio.com/blog/rails-api-tests-rspec/)
- [let & let! explained](https://www.codewithjason.com/difference-let-let-instance-variables-rspec/)
- [Upcase Testing Videos](https://thoughtbot.com/upcase/testing)

[rails application template]: https://guides.rubyonrails.org/rails_application_templates.html
