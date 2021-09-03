# Rails API Lab Templates

A [Rails Application Template][templating guide] for generating new Rails API labs 
with updated dependencies.

Usage:

```sh
rails new <lab-name> -BT --api --minimal -m=https://raw.githubusercontent.com/learn-co-curriculum/phase-4-rails-api-lab-template/main/template.rb
```

## Notes

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

- Add [`rspec-rails`](https://github.com/rspec/rspec-rails) gem to the
  development and test groups
- Add [`shoulda-matchers`](https://github.com/thoughtbot/shoulda-matchers) gem
  to test group
- Add
  [`rspec-json_expectations`](https://github.com/waterlink/rspec-json_expectations)
  gem to test group
- Run `rails generate rspec:install`

## Add Session/Cookie Middleware

To help with lessons on auth, this adds back in the session/cookie middleware.

- Update `config/application.rb` with middleware
- Update `app/controllers/application_controller.rb` with cookie helpers

## Generate React Application

Optionally include a React client.

- Use `npx create-react-app client --use-npm` to generate a React app
  in the `client` directory
- Add `"proxy": "http://localhost:3000"` to `package.json` to
  [proxy API requests](https://create-react-app.dev/docs/proxying-api-requests-in-development/)
- Add `rake install` script

The [foreman gem](https://github.com/ddollar/foreman) lets us run multiple
processes from a Procfile. This means we can create a `rails start` script
to run Rails and React together.

- Add `Procfile.dev` with process runner instructions
- Add `rake start` task

Note: `foreman` shouldn't be included in the Gemfile. Instruct users to install
`foreman` globally:

```sh
gem install foreman
```

## Resources

### Templating

- [Rails Docs on Templating][templating guide]
- [Rails Templating Blog](http://www.rutionrails.com/blog/2016/7/8/regarding-rails-templates-1)
- [Thor Actions Wiki](https://github.com/erikhuda/thor/wiki/Actions) and [Docs](https://rdoc.info/github/erikhuda/thor/master/Thor/Actions)

### Testing

- [RSpec API Testing](https://rubyyagi.com/rspec-request-spec/)
- [More RSpec API Testing](https://www.nopio.com/blog/rails-api-tests-rspec/)
- [let & let! explained](https://www.codewithjason.com/difference-let-let-instance-variables-rspec/)
- [Upcase Testing Videos](https://thoughtbot.com/upcase/testing)

[templating guide]: https://guides.rubyonrails.org/rails_application_templates.html
