module Prismatic::ElementContainer
  private

  def create_elements
    find_matches 'element'
    find_matches 'elements'
    find_matches 'section'
    find_matches 'sections'
  end

  def find_matches(type)
    attribute = attribute_for(type)

    find_all("[#{attribute}]").each do |el|
      name = el[attribute]
      if is_section?(type)
        self.class.send type.intern, name, Prismatic::Section, "[#{attribute}=\"#{name}\"]"
      else
        self.class.send type.intern, name, "[#{attribute}=\"#{name}\"]"
      end
    end
  end

  def is_section?(type)
    type.start_with?('section')
  end

  def attribute_for(type)
    "data-prism-#{type}"
  end
end
