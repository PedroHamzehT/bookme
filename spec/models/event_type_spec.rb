require 'rails_helper'

RSpec.describe EventType, type: :model do
  describe '#define_slug' do
    let(:event_type) { build(:event_type, name: 'Slug test') }

    it 'must define slug before create' do
      debugger
      expect { event_type.save }.to change { event_type.slug }.to(event_type.name.parameterize)
    end
  end
end
