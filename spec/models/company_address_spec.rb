require 'rails_helper'

RSpec.describe CompanyAddress, type: :model do
  it 'is valid with params' do
    company_address = create(:company_address, :with_city, :with_company)
    expect(company_address).to be_valid
  end

  context 'Validates' do
    it { is_expected.to validate_presence_of(:street_address) }
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:zip_code) }
    it { is_expected.to validate_presence_of(:city_id) }
    it { is_expected.to validate_presence_of(:company_id) }
  end

  context 'Associations' do
    it { is_expected.to belong_to(:company) }
    it { is_expected.to belong_to(:city) }
  end
end