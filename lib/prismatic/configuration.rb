require 'docile'

module Prismatic::Configuration
  OPTIONS_AND_DEFAULTS = {
    prefix:                  'prism',
    auto_create_url_matcher: true,
  }

  OPTIONS_AND_DEFAULTS.each do |option, default|
    define_method option do |value = :no_value_supplied|
      v = "@#{option}"
      if instance_variable_defined?(v) and value == :no_value_supplied
        return instance_variable_get(v)
      end
      new_value = value == :no_value_supplied ? default : value
      instance_variable_set(v, new_value)
    end
  end

  def configure(&block)
    Docile.dsl_eval(self, &block)
  end

  def reset_configuration
    OPTIONS_AND_DEFAULTS.each do |option, default|
      v = "@#{option}"
      instance_variable_set(v, default)
    end
    true
  end
end
