class Prismatic::Page < SitePrism::Page
  include Prismatic::ElementContainer

  def initialize
    create_elements
  end
end
