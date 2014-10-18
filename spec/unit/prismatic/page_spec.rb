describe Prismatic::Page do
  def make_element(name, attribute)
    el = double(Capybara::Node::Element)
    allow(el).to receive(:[]).with(attribute).and_return(name)
    el
  end

  def make_section(name, attribute)
    el = double("Prismatic::Section, #{name}")
    allow(el).to receive(:[]).with(attribute).and_return(name)
    el
  end

  let(:page) { double(Capybara::Session) }
  let(:page_element_array) { [] }
  let(:page_elements_array) { [] }
  let(:page_section_array) { [] }
  let(:page_sections_array) { [] }
  let(:singleton_element) { make_element('foo', 'data-prism-element') }
  let(:collection_element) { make_element('bar', 'data-prism-elements') }

  specify { expect(subject).to be_a(SitePrism::Page) }

  before do
    allow(Capybara).to receive(:current_session).and_return(page)
    allow(page).to receive(:all).with('[data-prism-element]').and_return(page_element_array)
    allow(page).to receive(:all).with('[data-prism-elements]').and_return(page_elements_array)
    allow(page).to receive(:all).with('[data-prism-section]').and_return(page_section_array)
    allow(page).to receive(:all).with('[data-prism-sections]').and_return(page_sections_array)
  end

  context "for 'data-prism-element' attributes" do
    let(:page_element_array) { [singleton_element] }

    it "creates a single element" do
      expect(subject).to respond_to('foo')
    end
  end

  context "for 'data-prism-elements' attributes" do
    let(:page_elements_array) { [collection_element] }
    let(:bar_elements_array) { page_elements_array }

    before do
      allow(page).to receive(:all).with('[data-prism-elements="bar"]').and_return(bar_elements_array)
    end

    it "creates an arrays of elements" do
      expect(subject.bar).to be_a(Array)
    end
  end

  context 'sections' do
    context "for 'data-prism-section' attributes" do
      let(:section_name) { 'singleton-section' }
      let(:singleton_section) { make_section(section_name, 'data-prism-section') }
      let(:page_section_array) { [singleton_section] }
      let(:foo_element_array) { [] }
      let(:bar_elements_array) { [] }
      let(:nested_section_array) { [] }
      let(:nested_sections_array) { [] }

      before do
        allow(page).to receive(:all).with("[data-prism-section=\"#{section_name}\"]").and_return([singleton_section])
        allow(page).to receive(:find).with("[data-prism-section=\"#{section_name}\"]").and_return(singleton_section)
        allow(singleton_section).to receive(:all).with('[data-prism-element]').and_return(foo_element_array)
        allow(singleton_section).to receive(:all).with('[data-prism-elements]').and_return(bar_elements_array)
        allow(singleton_section).to receive(:all).with('[data-prism-section]').and_return(nested_section_array)
        allow(singleton_section).to receive(:all).with('[data-prism-sections]').and_return(nested_sections_array)
      end

      it "creates a single section" do
        expect(subject).to respond_to(section_name)
      end

      context "with contained 'data-prism-element' attributes" do
        let(:foo_element_array) { [singleton_element] }

        before do
          allow(singleton_section).to receive(:find).with('[data-prism-element="foo"]').and_return(singleton_element)
          allow(singleton_section).to receive(:find).with('[data-prism-elements="foo"]').and_return([])
        end

        it 'creates an element' do
          expect(subject.send(section_name)).to respond_to(:foo)
        end
      end

      context "with contained 'data-prism-elements' attributes" do
        let(:bar_elements_array) { [collection_element] }

        before do
          allow(singleton_section).to receive(:all).with('[data-prism-element="foo"]').and_return(foo_element_array)
          allow(singleton_section).to receive(:all).with('[data-prism-elements="foo"]').and_return(bar_elements_array)
          allow(singleton_section).to receive(:find).with('[data-prism-element="foo"]').and_return([])
          allow(singleton_section).to receive(:find).with('[data-prism-elements="foo"]').and_return(collection_element)
        end

        it 'creates an element array' do
          expect(subject.send(section_name).foo).to be_a(Array)
        end
      end

      context "for heirarchies of DOM elements with 'data-prism-section' attributes" do
        let(:baz_section) { make_section('baz', 'data-prism-section') }
        let(:nested_section_array) { [baz_section] }

        it "creates a heirarchy of sections containing elements" do
          expect(subject.send(section_name)).to respond_to(:baz)
        end
      end
    end

    context "for 'data-prism-sections' attributes" do
      let(:collection_name) { 'collection' }
      let(:section_collection_member) { make_section(collection_name, 'data-prism-sections') }
      let(:page_sections_array) { [section_collection_member] }
      let(:foo_element_array) { [] }
      let(:bar_elements_array) { [] }

      before do
        allow(page).to receive(:all).with('[data-prism-section]').and_return([])
        allow(page).to receive(:all).with("[data-prism-sections=\"#{collection_name}\"]").and_return(page_sections_array)
        allow(page).to receive(:find).with("[data-prism-sections=\"#{collection_name}\"]").and_return(section_collection_member)
        allow(section_collection_member).to receive(:all).with('[data-prism-element]').and_return(foo_element_array)
        allow(section_collection_member).to receive(:all).with('[data-prism-elements]').and_return(bar_elements_array)
        allow(section_collection_member).to receive(:all).with('[data-prism-section]').and_return([])
        allow(section_collection_member).to receive(:all).with('[data-prism-sections]').and_return([])
      end

      it "creates an array of sections" do
        expect(subject.send(collection_name)).to be_a(Array)
      end
    end
  end
end
