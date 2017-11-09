# Rubocop::Rules

A common place to house rubocop rule enforcement across projects.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubocop_rules', require: false
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubocop_rules

## Usage

After installing the gem, you need to initialize your project using the provided CLI.

### Initializing a project

Initialize your project with the cli: `rubocop-rules init`

This will create `.rubocop.yml` and `rubucop_common.yml`, it will then run `rubucop -a` to automatically fix what can be fixed for you.
In addition to this it will create `rubucop_todo.yml` to put what cannot be fixed in quarantine for you to fix later.

Finally, a linter spec to make sure your code is following the common conventions.

### Updating a project

Whenever a new version of the gem is deployed, you may update your project configuration using the command: `rubocop-rules update`. This command
will get a fresh copy of `rubucop_common.yml`, it will run autofixes and regenerate a new `rubucop_todo.yml` for you.

## Development

Bug reports and pull requests are welcome on GitHub at https://github.com/klarna/rubocop_rules.
