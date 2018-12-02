require 'rails_helper'

RSpec.describe CompanyContact, type: :model do
  it 'is valid with params' do
    company_contact = create(:company_contact, :send_document, :with_company)
    expect(company_contact).to be_valid
  end

  context 'Validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:personal_title) }
    it { is_expected.to validate_presence_of(:occupation) }
    it { is_expected.to validate_presence_of(:sector) }

    it 'is send_document' do
      company_contact = build(:company_contact, :send_document)
      expect(company_contact.send_document).to be_truthy
    end

    it 'is not send_document' do
      company_contact = build(:company_contact, :not_send_document)
      expect(company_contact.send_document).to be_falsey
    end

    it 'is invalid send_document' do
      company_contact = build(:company_contact, :invalid_send_document)
      expect(company_contact).to be_invalid
    end
  end

  context 'Associations' do
    it { is_expected.to belong_to(:company) }
    it { is_expected.to have_many(:documents) }
    it { is_expected.to have_many(:responsibles) }
  end

  context 'Instance Methods' do
    it '#send_document_description (TRUE)' do
      company_contact = build(:company_contact, :send_document)
      expect(company_contact.send_document_description).to eq(I18n.t('helpers.links.yess'))
    end

    it '#send_document_description (FALSE)' do
      company_contact = build(:company_contact, :not_send_document)
      expect(company_contact.send_document_description).to eq(I18n.t('helpers.links.noo'))
    end

    it '#text_dropdown_responsibles' do
      company_contact = build(:company_contact, :with_company)
      expect(company_contact.text_dropdown_responsibles).to eq("#{company_contact.name} - #{company_contact.occupation} - #{company_contact.sector} - #{company_contact.company.trade_name}")
    end

  end
end