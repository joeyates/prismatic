require 'prismatic'

describe Prismatic::Configuration do
  after do
    Prismatic.reset_configuration
  end

  [
    [:prefix,                  'prism', 'foo'],
    [:auto_create_url_matcher, true,    false],
  ].each do |option, default, new_value|
    describe "##{option}" do
      it 'returns the value' do
        expect(Prismatic.send(option)).to eq(default)
      end

      context 'setting' do
        it 'sets the value' do
          Prismatic.send(option, new_value)
          expect(Prismatic.send(option)).to eq(new_value)
        end

        it "accepts 'nil'" do
          Prismatic.send(option, nil)
          expect(Prismatic.send(option)).to eq(nil)
        end

        it 'returns the value' do
          expect(Prismatic.send(option, new_value)).to eq(new_value)
        end
      end
    end
  end

  context '.configure' do
    it 'sets values in the block' do
      Prismatic.configure do
        prefix 'bar'
      end

      expect(Prismatic.prefix).to eq('bar')
    end
  end

  context '.reset_configuration' do
    it 'resets options to defaults' do
      Prismatic.prefix 'aaaaaaa'

      Prismatic.reset_configuration

      expect(Prismatic.prefix).to eq('prism')
    end
  end
end
