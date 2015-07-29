# InstanceStorage

クラスにincludeすると、クラスインスタンスごとにSymbolを割り振って、あとからその名前でインスタンスにアクセスする機能を提供します。

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'instance_storage'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install instance_storage

## Usage

```ruby
class Tag
  include InstanceStorage
end

foo = Tag[:foo]  # generate instance `foo'
foo.name         # => :foo
foo == Tag[:foo] # => true
foo == Tag[:bar] # => false
```

## Contributing

1. Fork it ( https://github.com/toshia/instance_storage/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
