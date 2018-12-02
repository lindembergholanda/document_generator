require 'rails_helper'

RSpec.describe Country, type: :model do
  it 'is valid with params' do
    country = create(:country)
    expect(country).to be_valid
  end

  context 'Validates' do
    it { is_expected.to validate_presence_of(:name) }
  end

  context 'Associations' do
    it { is_expected.to have_many(:states) }
  end
end