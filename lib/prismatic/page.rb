class Prismatic::Page < SitePrism::Page
  include Prismatic::ElementContainer

  def load
    super
    create_elements
  end
end
