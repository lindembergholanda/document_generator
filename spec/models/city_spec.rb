require 'rails_helper'

RSpec.describe City, type: :model do
  it 'is valid with params' do
    city = create(:city, :capital, :with_state)
    expect(city).to be_valid
  end

  context 'Validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:state_id) }

    it 'is capital' do
      city = build(:city, :capital)
      expect(city.capital).to be_truthy
    end

    it 'is not capital' do
      city = build(:city, :not_capital)
      expect(city.capital).to be_falsey
    end

    it 'is invalid capital' do
      city = build(:city, :invalid_capital)
      expect(city).to be_invalid
    end
  end

  context 'Associations' do
    it { is_expected.to belong_to(:state) }
    it { is_expected.to have_many(:company_address) }
  end
end