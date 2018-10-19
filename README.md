[![Build Status](https://travis-ci.org/klippx/rubocop_rules.svg?branch=master)](https://travis-ci.org/klippx/rubocop_rules)

# Rubocop Rules

A common place to house rubocop rule enforcement across projects.

When you or your team have a large number of repos, with different Rubocop Rules spread all over the
place, it gets hard to maintain and sync all "shared" config together with project specific
"tweaks", as well as todos that are more like todonts...

This is where this tool can be quite handy. It enables you to put all SHARED stuff in one single
place, and you and your team can develop this file gradually over time. This tool downloads the
latest version and applies it to your project, leaving you with clean rubocop_todo files and still
allowing you to have project specific overrides.

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

Initialize your project with the cli: `rubocop-rules init`, sample output:

```shell
$ bundle exec rubocop-rules init
Copying config...
      create  .rubosync.yml
      create  .rubocop.yml
      create  spec/lint_spec.rb
Downloading latest configuration from git://github.com/klippx/rubocop_rules.git...
      create  .rubocop_common.yml
Autocorrecting your code... 28 files inspected, 59 offenses detected
Generating rubocop_todo... Run `rubocop --config .rubocop_todo.yml`, or add `inherit_from: .rubocop_todo.yml` in a .rubocop.yml file.
Adding rubocop_todo to configuration...
      insert  .rubocop.yml
```

This will create a few files:

* `.rubosync.yml` is the configuration object for this micro-framework. Use this to configure your
  git remote hosting the shared rubocop configuration. By default it will use this repo, which is
  empty. The idea is to customize this.
* `.rubocop.yml` will source the required rubocop yml files
* `rubucop_common.yml` is downloaded from git remote specified in `.rubosync.yml`. Note that it
  expects the `rubucop_common.yml` in the root of this git repo.

The script it will then run `rubucop -a` to automatically fix what can be fixed for you. In addition
to this it will create `rubucop_todo.yml` to put what cannot be fixed in quarantine for you to fix
later.

Finally, a linter spec `spec/lint_spec.rb` is added to make sure your code is following the common
conventions.

### Updating a project

Whenever a new version of the gem is deployed, you may update your project configuration using the
command: `rubocop-rules update`. This command will download a fresh copy of `rubucop_common.yml`, it
will run autofixes and regenerate a new `rubucop_todo.yml` for you!

Sample output:

```shell
$ bundle exec rubocop-rules update
Recreating configuration...
      remove  .rubocop_common.yml
Downloading latest configuration from ssh://git@stash.int.klarna.net:7999/klapp/rubocop_common.git...
      create  .rubocop_common.yml
Regenerating rubocop_todo...
      remove  .rubocop_todo.yml
        gsub  .rubocop.yml
        gsub  .rubocop.yml
```

## Best practices

### .rubosync.yml

Only configured once per repo, point it to the correct remote.

### .rubocop_common.yml

Never update `.rubocop_common.yml` directly. Allow this tool take care of this for you.

If you feel that you need to update the config in `.rubocop_common.yml`, update it on the shared git
repo housing this file instead, and then reissue the `rubocop-rules update` command.

### .rubocop_todo.yml

Never update `.rubocop_todo.yml` directly. Allow this tool take care of this for you.

If you feel that you need to update the config in `.rubocop_todo.yml`, fix the actual source code
and then reissue the `rubocop-rules update` command.

### .rubocop.yml

Update `.rubocop.yml` for project specific overrides. Could be a project with a very large Rake task
that is pending removal rather than refactoring.

Keep this to a minimum and always consider if it belongs in .rubocop_common.yml or not.

## Development

Bug reports and pull requests are welcome on GitHub at https://github.com/klippx/rubocop_rules.
