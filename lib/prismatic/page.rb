class Prismatic::Page < SitePrism::Page
  include Prismatic::ElementContainer

  def load(*args)
    super(*args)
    optionally_update_elements
  end

  def respond_to?(method_id, include_all = false)
    optionally_update_elements
    methods.include?(method_id)
  end

  def method_missing(method_id, *args)
    optionally_update_elements
    return super unless methods.include?(method_id)
    send(method_id, *args)
  end

  private

  def optionally_update_elements
    optionally_set_url_matcher
    return unless displayed?(0)
    update_elements
  end

  def optionally_set_url_matcher
    return unless self.class.url_matcher.nil?
    return if self.class.url.nil?
    return unless Prismatic.auto_create_url_matcher
    self.class.set_url_matcher %r(^https?://[^/]+#{self.class.url}([#\?].*)?$)
  end
end
