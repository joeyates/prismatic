# Prismatic

[![Build Status](https://secure.travis-ci.org/joeyates/prismatic.png)][Continuous Integration]
[![Code Climate](https://codeclimate.com/github/joeyates/prismatic/badges/gpa.svg)](https://codeclimate.com/github/joeyates/prismatic)
[![Test Coverage](https://codeclimate.com/github/joeyates/prismatic/badges/coverage.svg)](https://codeclimate.com/github/joeyates/prismatic)

  * [Source Code]
  * [API documentation]
  * [Rubygem]
  * [Continuous Integration]

[Source Code]: https://github.com/joeyates/prismatic "Source code at GitHub"
[API documentation]: http://rubydoc.info/gems/prismatic/frames "RDoc API Documentation at Rubydoc.info"
[Rubygem]: http://rubygems.org/gems/prismatic "Ruby gem at rubygems.org"
[Continuous Integration]: http://travis-ci.org/joeyates/prismatic "Build status by Travis-CI"

Use a naming convention inside your HTML to describe the DOM elements you
want to access during tests. Prismatic will set up your SitePrism::Pages
with the intended Sections and Elements.

## Motivation

SitePrism is a wonderful tool for describing web pages in integration tests.
Unfortunately, it requires the creation of classes which use CSS selectors
(of XPath expressions) to indicate the elements of interest.

Prismatic aims to allow you skip the use of SitePrism's Page Object Model
by indicating in the web page itself which are the objects you want to access
in your tests thanks to [data attributes](http://www.w3.org/html/wg/drafts/html/master/dom.html#embedding-custom-non-visible-data-with-the-data-*-attributes).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'prismatic'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install prismatic
```

## Usage

Add the following attributes to your HTML markup:

* data-prism-element
* data-prism-elements
* data-prism-section
* data-prism-sections

Given a 'search#index' page containing this:

```html
...
<form data-prism-section="search" method="get" action="search">
  <input type="text" data-prism-element="query">
  <input type="submit" data-prism-element="start" value="Search">
</form>
...
```

Create a page class:

```ruby
class SearchIndexPage < Prismatic::Page
  set_url '/search'
end
```

When you load the page, the sections and elements are defined:

```ruby
search_page = SearchIndexPage.new
search_page.load
expect(search_page.search.start.text).to eq('Search')
```

## Warnings

* all Pages need an `url_matcher` so that Prismatic knows when a page is
  actually loaded. If you don't specify one, Prismatic will create it
  (see `auto_create_url_matcher` configuration setting),
* be careful with `wait_for_*`: you may need to manually define a section
  or element you intend to use as a marker that content is loaded - Prismatic
  won't create them until they are actually present.

## Configuration

In your test setup, do this:

```ruby
Prismatic.configure do
  foo :bar
end
```

Configuration options:

* prefix: (default: 'prism'). By default, prismatic uses data attributes called 
  'data-prism-*'. Set prefix to another value to allow data attributes to be
  named differently.
* auto_create_url_matcher: (default: true). If a Page has no `url_matcher` defined,
  this sets it to a Regexp based on the Page's `url`.

## Contributing

1. Fork it ( https://github.com/joeyates/prismatic/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
