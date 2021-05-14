# Rails API Lab Template: API Only

## Usage

```sh
rails new <lab-name> -BT --api --minimal -m=https://raw.githubusercontent.com/learn-co-curriculum/phase-4-rails-api-lab-template/main/template.rb
```

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
