require 'rails_helper'

RSpec.describe Document, type: :model do
  it 'is valid with params' do
    document = create(:document, :with_subject, :with_company_contact, :with_responsible)
    expect(document).to be_valid
  end

  context 'Validates' do
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:company_contact_id) }
    it { is_expected.to validate_presence_of(:subject_id) }
    it { is_expected.to validate_presence_of(:responsible_id) }
  end

  context 'Associations' do
    it { is_expected.to belong_to(:subject) }
    it { is_expected.to belong_to(:company_contact) }
    it { is_expected.to belong_to(:responsible) }
  end

  context 'Instance Methods' do
    it '#contacts_to_dropdown' do
      document = build(:document, :with_company_contact)
      expect(document.contacts_to_dropdown).to eq(document.company_contact.company.company_contacts)
    end

  end

  context 'Callbacks' do
    it '#generate_number' do
      document = build(:document, :with_subject, :with_company_contact, :with_responsible)
      expect(document).to receive(:generate_number)
      document.save
    end

    it '#generate_autentication' do
      document = build(:document, :with_subject, :with_company_contact, :with_responsible)
      expect(document).to receive(:generate_autentication)
      document.save
    end
  end
end