# Mongoid::Bitfield  ![build status](http://travis-ci.org/asaaki/mongoid_bitfield.png)

## About

This tiny gem provides a bitfield or a collection of boolean bits/flags.

This bitfield will be stored as an integer value in the mongodb database.

## Install

```shell
gem install mongoid_bitfield
```

or

Gemfile:

```ruby
gem "mongoid_bitfield"
```

## Usage

### Model setup

```ruby
class User
  include Mongoid::Document
  include Mongoid::Bitfield

  bitfield :flags, :is_admin, :adult, :drinker
end
```

### Instance

**without automatic saving**

```ruby
user = User.new

user.is_admin #=> false

user.is_admin = true

user.is_admin #=> true
```

**atomic saving of changes**

```ruby
user = User.create!

user.drinker_enable!

user.reload

user.drinker #=> true
```

## License

MIT/X11

Copyright (c) 2012 Christoph 'asaaki' Grabo