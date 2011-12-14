# acts_as_subscribable

acts_as_subscribable is a small Rubygem that provides a high-level wrapper around `ActiveRecord::Base` to allow a model to 'subscribe' to another given model. This could be a `User` subscribing to a `Task` for example, or a `Member` subscribing to a `Thread` or even a `Watcher` subscribing to a `Channel`.

It's essentially a glorified version of a `has_many :through` association, but it adds a few methods to make the lookups and searching a little easier and more readable.

This is my first proper Rubygem so you'll have to bear with me on this one. If you've any suggestions of ways to improve the code, please feel free to contribute.

**[acts_as_subscribable was kindly funded by the marvellous Mission Control task management.](http://missioncontrolhq.com)**

## Synopsis

```ruby
class Todo < ActiveRecord::Base
  acts_as_subscribable
end
```

## Setup

Add it to your Gemfile:

```ruby
gem 'acts_as_subscribable'
```

..and then `bundle install`. Once that's installed, we can run the built-in generator to generate our `Subscription` model, with an optional model name, subscribed foreign key and subscriber foreign key as parameters:

```bash
$ rails g acts_as_subscribable Subscription
```

This will generate our Subscription model with the appropriate migration. Run your migrations and add the `acts_as_subscribable` call to your model that you wish to be subscribable:

```ruby
class Todo < ActiveRecord::Base
  acts_as_subscribable
end
```

## Usage

We now have our wrapper in place. We use a bunch of sane defaults; the subscriber model defaults to `User`, so we'll be subscribing `User`s to `Todo`s.

```ruby
 > t = Todo.first
 > u = User.first
 
 > t.subscribe u
 
 > t.subscribed? u
=> true
 
 > t.subscribers
=> [ #<User id: 1 ...> ]
 
 > t.unsubscribe u
 
 > t.subscribed? u
=> false
```

## Where are the specs?

I started writing a test suite, I promise! Just got too busy, and the metaprogramming stuff was too fiddly to test.

## License

Copyright (c) 2011 Jamie Rumbelow, http://jamierumbelow.net

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.