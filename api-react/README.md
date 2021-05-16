# Rails API Lab Template: API with React Frontend

## Usage

```sh
rails new <lab-name> -BT --api --minimal -m=https://raw.githubusercontent.com/learn-co-curriculum/phase-4-rails-api-lab-template/main/api-react/template.rb
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

## Install and Configure Foreman

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

## Add Session/Cookie Middleware

To help with lessons on auth, this adds back in the session/cookie middleware.

- Update `config/application.rb` with middleware
- Update `app/controllers/application_controller.rb` with cookie helpers

## Generate React Application

- Use `npx create-react-app client --use-npm` to generate a React app
  in the `client` directory
- Add `"proxy": "http://localhost:3000"` to `package.json` to
  [proxy API requests](https://create-react-app.dev/docs/proxying-api-requests-in-development/)
