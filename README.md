# Rails API Lab Templates

Several [Rails Application Templates][] for generating new Rails API labs with
updated dependencies.

## Rails API Only

```sh
rails new <lab-name> -BT --api --minimal -m=https://raw.githubusercontent.com/learn-co-curriculum/phase-4-rails-api-lab-template/master/api-only/template.rb
```

## Rails API w/React

```sh
rails new <lab-name> -BT --api --minimal -m=https://raw.githubusercontent.com/learn-co-curriculum/phase-4-rails-api-lab-template/master/api-react/template.rb
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
