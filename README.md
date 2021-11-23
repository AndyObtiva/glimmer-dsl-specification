# [<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=85 />](https://github.com/AndyObtiva/glimmer) Glimmer DSL for Specification 0.0.1
## Pure Ruby Declarative Use Case Specification and Automated Verification
[![Gem Version](https://badge.fury.io/rb/glimmer-dsl-specification.svg)](http://badge.fury.io/rb/glimmer-dsl-specification)
[![Join the chat at https://gitter.im/AndyObtiva/glimmer](https://badges.gitter.im/AndyObtiva/glimmer.svg)](https://gitter.im/AndyObtiva/glimmer?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Despite Ruby's highly expressive nature, all testing toolkits written in Ruby are either imperative (e.g. using `assert` or `expect`), thus losing expressiveness and focusing software engineers on the wrong thing, or mix non-Ruby code with Ruby (e.g. `cucumber` & `gherkin`), thus missing out on the simplicity of Ruby.

[Glimmer](https://github.com/AndyObtiva/glimmer) DSL for Specification aims to provide a simple minimalistic and noun-based declarative syntax. No more verbs! It is time to think declaratively not imperatively!

As such, software engineers focus on [Requirements Specification](https://en.wikipedia.org/wiki/Software_requirements_specification) at the [Use Case](https://en.wikipedia.org/wiki/Use_case) level whereby each use case is composed of multiple scenarios. No need to specify scenario steps. The code is the steps!!!

Also, no need for extra DSL constructs for making comparisons in verification statements. Just use plain old Ruby and let the library figure out the rest!

For example:

```ruby
scenario 'Same-content strings are equal' do
  'string' == 'string'
end
```

That tells me the whole story without needing either `assert` or `expect`. It just contains plain Ruby code for performing the comparison.

Another example:

```ruby
scenario 'person name consists of first name and last name' do
  person = Person.new(first_name: 'Bob', last_name: 'Winfrey')
  
  fact { person.first_name == 'Bob' }
  fact { person.last_name == 'Winfrey' }
  person.name == 'Bob Winfrey'
end
```

That states a few extra facts in addition to the last statement in the scenario denoting the final verification.

Of course, if a verification does not complete, then the onus is on the software engineer to print out the right variables to fix (the included [puts_debuggerer](https://github.com/AndyObtiva/puts_debuggerer/) makes such a task much more convenient)

Note that this library is very new and experimental, so it might change course significantly. Also, despite the bold ambitious statements, there might be obvious blind spots that your feedback would help shine light upon to improve the library. As such, ideas and suggestions are greatly welcome.

Other [Glimmer](https://rubygems.org/gems/glimmer) DSL gems you might be interested in:
- [glimmer-dsl-swt](https://github.com/AndyObtiva/glimmer-dsl-swt): Glimmer DSL for SWT (JRuby Desktop Development GUI Framework)
- [glimmer-dsl-opal](https://github.com/AndyObtiva/glimmer-dsl-opal): Glimmer DSL for Opal (Pure Ruby Web GUI and Auto-Webifier of Desktop Apps)
- [glimmer-dsl-tk](https://github.com/AndyObtiva/glimmer-dsl-tk): Glimmer DSL for Tk (MRI Ruby Desktop Development GUI Library)
- [glimmer-dsl-libui](https://github.com/AndyObtiva/glimmer-dsl-libui): Glimmer DSL for LibUI (Prerequisite-Free Ruby Desktop Development GUI Library)
- [glimmer-dsl-gtk](https://github.com/AndyObtiva/glimmer-dsl-gtk): Glimmer DSL for GTK (Ruby-GNOME Desktop Development GUI Library)
- [glimmer-dsl-xml](https://github.com/AndyObtiva/glimmer-dsl-xml): Glimmer DSL for XML (& HTML)
- [glimmer-dsl-css](https://github.com/AndyObtiva/glimmer-dsl-css): Glimmer DSL for CSS

## Full Example

This library was written specification-first utilizing itself. In fact, here is the initial specification of [glimmer-dsl-specification](https://rubygems.org/gems/glimmer-dsl-specification) to prove it!

```ruby
require 'glimmer-dsl-specification'

class Person
  attr_reader :first_name, :last_name
  
  def initialize(first_name: , last_name: )
    @first_name = first_name
    @last_name = last_name
  end
  
  def name
    "#{first_name} #{last_name}"
  end
end

module Glimmer::Specification
  specification('Glimmer DSL for Specification') {
    use_case('Compare Two Objects for Equality') {
      scenario 'Same-content strings are equal' do
        'string' == 'string'
      end
      
      scenario 'Different-content strings are not equal' do
        'string1' != 'string2'
      end
      
      scenario 'Same-number integers are equal' do
        1 == 1
      end
      
      scenario 'Different-number integers are not equal' do
        1 != 2
      end
    }
    
    use_case('Verify Multiple Facts') {
      scenario 'person name consists of first name and last name' do
        person = Person.new(first_name: 'Bob', last_name: 'Winfrey')
        
        fact { person.first_name == 'Bob' }
        fact { person.last_name == 'Winfrey' }
        person.name == 'Bob Winfrey'
      end
    }
  }
end
```

Output (colored in actual usage):

```
VERIFIED: Glimmer DSL for Specification - Compare Two Objects for Equality - Same-content strings are equal
VERIFIED: Glimmer DSL for Specification - Compare Two Objects for Equality - Different-content strings are not equal
VERIFIED: Glimmer DSL for Specification - Compare Two Objects for Equality - Same-number integers are equal
VERIFIED: Glimmer DSL for Specification - Compare Two Objects for Equality - Different-number integers are not equal
VERIFIED: Glimmer DSL for Specification - Compare Two Objects for Equality
VERIFIED: Glimmer DSL for Specification - Verify Multiple Facts - person name consists of first name and last name - fact { person.first_name == 'Bob' }
VERIFIED: Glimmer DSL for Specification - Verify Multiple Facts - person name consists of first name and last name - fact { person.last_name == 'Winfrey' }
VERIFIED: Glimmer DSL for Specification - Verify Multiple Facts - person name consists of first name and last name
VERIFIED: Glimmer DSL for Specification - Verify Multiple Facts
VERIFIED: Glimmer DSL for Specification
```

Failure output when fudging some code (colored in actual usage):

```
VERIFIED: Glimmer DSL for Specification - Compare Two Objects for Equality - Same-content strings are equal
VERIFIED: Glimmer DSL for Specification - Compare Two Objects for Equality - Different-content strings are not equal
VERIFIED: Glimmer DSL for Specification - Compare Two Objects for Equality - Same-number integers are equal
VERIFIED: Glimmer DSL for Specification - Compare Two Objects for Equality - Different-number integers are not equal
VERIFIED: Glimmer DSL for Specification - Compare Two Objects for Equality
VERIFIED: Glimmer DSL for Specification - Verify Multiple Facts - person name consists of first name and last name - fact { person.first_name == 'Bob' }
VERIFIED: Glimmer DSL for Specification - Verify Multiple Facts - person name consists of first name and last name - fact { person.last_name == 'Winfrey' }
NOT VERIFIED: Glimmer DSL for Specification - Verify Multiple Facts - person name consists of first name and last name
NOT VERIFIED: Glimmer DSL for Specification - Verify Multiple Facts
NOT VERIFIED: Glimmer DSL for Specification
```

## Usage

1 - Include in `Gemfile` (`:development` or `:test` group):

```ruby
gem 'glimmer-dsl-specification', '~> 0.0.1'
```

And, run:

```
bundle
```

2 - Create specification files with `_specification.rb` extension under `specification` directory utilizing `specification`, `use_case`, `scenario`, and `fact` keywords explained in [DSL](#dsl) section by adding require statement on top and inserting specification/verification code in `Glimmer::Specification` module:

```ruby
require 'glimmer-dsl-specification'

module Glimmer::Specification
  specification('title of specification') {
    use_case('title of use case') {
      scenario('second scenario') {
        fact { something2 == something_else2 } # optional
        fact { something3 != something_else3 } # optional
        fact { something1.include?(something_else1) } # optional
        something == something_else # final verification can be a fact if preferred
      }
    }
  }
end
```

3 - Run a specification directly with ruby:

```
ruby specification/lib/glimmer-dsl-specification_specification.rb
```

4 - Alternatively run `rake verify` task assuming you have `rake` gem installed/configured in `Gemfile`:

```
rake verify
```

It is also recommended that you add the following lines to your `Rakefile`:

```ruby
require 'glimmer-dsl-specification' # unless loaded by Bundler
require 'glimmer/specification/rake_tasks'

task :default => :verify
```

That way, you can simply run:

```
rake
```

## DSL

The Domain Specific Language consists of the following keywords simply nested under `Glimmer::Specification` module (to avoid namespace pollution).

This library highly emphasizes declarative specification, so it avoids unit-test jargon including "class", "method", "attribute", or "assert" as that is not the ultimate aim of the library, yet specifying application requirements.

Specifications do not care about what specific "classes" or "methods" are executed. They only care about meeting the verification criteria.

### specification

(nested directly under `Glimmer::Specification` module or under another `specification`.)

`specification(title)` is the top-level keyword denoting a requirement specification.

### use_case

(nested under `specification`)

`use_case(title)` represents one or more use cases that the requirement specification consists of

### scenario

(nested under `use_case` or directly under `specification` for very simple cases)

`scenario(title)` represents one scenario in a use case that performs a verification by setting up preconditions, performing an action, and returning the final result as a postconditition boolean or alternatively relying on nested `fact` occurances.

### fact

(nested under `scenario`)

`fact {}` states a fact embodied by a boolean result for the passed block of code.

## Process

[Glimmer Process](https://github.com/AndyObtiva/glimmer/blob/master/PROCESS.md)

## Resources

- [Code Master Blog](https://andymaleh.blogspot.com/search/label/glimmer)

## Help

### Issues

If you encounter [issues](https://github.com/AndyObtiva/glimmer-dsl-specification/issues) that are not reported, discover missing features that are not mentioned in [TODO.md](TODO.md), or think up better ways to write declarative automated tests, you may submit an [issue](https://github.com/AndyObtiva/glimmer-dsl-libui/issues/new) or [pull request](https://github.com/AndyObtiva/glimmer-dsl-specification/compare) on [GitHub](https://github.com). In the meantime, you may try an older version of the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-specification) in case it works better for you until your issues are resolved.

### Chat

If you need live help, try to [![Join the chat at https://gitter.im/AndyObtiva/glimmer](https://badges.gitter.im/AndyObtiva/glimmer.svg)](https://gitter.im/AndyObtiva/glimmer?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## TODO

[TODO.md](TODO.md)

## Change Log

[CHANGELOG.md](CHANGELOG.md)

## Contributing

-   Check out the latest master to make sure the feature hasn't been
    implemented or the bug hasn't been fixed yet.
-   Check out the issue tracker to make sure someone already hasn't
    requested it and/or contributed it.
-   Fork the project.
-   Start a feature/bugfix branch.
-   Commit and push until you are happy with your contribution.
-   Make sure to add tests for it. This is important so I don't break it
    in a future version unintentionally.
-   Please try not to mess with the Rakefile, version, or history. If
    you want to have your own version, or is otherwise necessary, that
    is fine, but please isolate to its own commit so I can cherry-pick
    around it.

## Copyright

[MIT](LICENSE.txt)

Copyright (c) 2021 Andy Maleh. See
[LICENSE.txt](LICENSE.txt) for further details.

--

[<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=40 />](https://github.com/AndyObtiva/glimmer) Built for [Glimmer](https://github.com/AndyObtiva/glimmer) (DSL Framework).
