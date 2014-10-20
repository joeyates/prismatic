require 'capybara'
require 'site_prism'

module Prismatic
end

require 'prismatic/configuration'
Prismatic.send :extend, Prismatic::Configuration
require 'prismatic/element_container'
require 'prismatic/page'
require 'prismatic/section'
require 'prismatic/version'
