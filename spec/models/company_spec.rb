require 'rails_helper'

RSpec.describe Company, type: :model do
  it 'is valid with params' do
    company = create(:company, :valid_cnpj)
    expect(company).to be_valid
  end

  context 'Validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:trade_name) }
    it { is_expected.to validate_presence_of(:cnpj) }

    it 'is valid cnpj' do
      company = build(:company, :valid_cnpj)
      expect(company).to be_valid
    end

    it 'is invalid cnpj' do
      company = build(:company, :invalid_cnpj)
      expect(company).to be_invalid
    end
  end

  context 'Associations' do
    it { is_expected.to have_many(:company_address) }
    it { is_expected.to have_many(:company_contacts) }
  end
end