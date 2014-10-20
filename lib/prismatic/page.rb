class Prismatic::Page < SitePrism::Page
  include Prismatic::ElementContainer

  def load
    super
    optionally_create_elements
  end

  def respond_to?(method_id, include_all = false)
    optionally_create_elements
    methods.include?(method_id)
  end

  def method_missing(method_id, *args)
    optionally_create_elements
    return super unless methods.include?(method_id)
    send(method_id, *args)
  end

  private

  def optionally_create_elements
    optionally_set_url_matcher
    return unless displayed?(0)
    create_elements
  end

  def optionally_set_url_matcher
    return unless self.class.url_matcher.nil?
    return if self.class.url.nil?
    return unless Prismatic.auto_create_url_matcher
    self.class.set_url_matcher %r(^https?://[^/]+#{self.class.url}([#\?].*)?$)
  end
end
