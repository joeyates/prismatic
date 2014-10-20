class Prismatic::Section < SitePrism::Section
  include Prismatic::ElementContainer

  def initialize(parent, root_element)
    super
    update_elements
  end
end
