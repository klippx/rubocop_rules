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

Initialize your project with the cli: `rubocop-rules init`

This will create .rubocop.yml and rubucop_common.yml, as well as a linter spec to make sure your code is following the common conventions.

## Development

Bug reports and pull requests are welcome on GitHub at https://github.com/klarna/rubocop_rules.
