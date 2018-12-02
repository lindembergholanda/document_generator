require 'rails_helper'

RSpec.describe State, type: :model do
  it 'is valid with params' do
    state = create(:state, :with_country)
    expect(state).to be_valid
  end

  context 'Validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:short_name) }
  end

  context 'Associations' do
    it { is_expected.to belong_to(:country) }
    it { is_expected.to have_many(:cities) }
  end
end