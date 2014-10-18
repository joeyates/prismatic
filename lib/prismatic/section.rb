class Prismatic::Section < SitePrism::Section
  include Prismatic::ElementContainer

  def initialize(parent, root_element)
    super
    create_elements
  end
end
