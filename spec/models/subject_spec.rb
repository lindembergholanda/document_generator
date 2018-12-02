require 'rails_helper'

RSpec.describe Subject, type: :model do
  it 'is valid with params' do
    subject = create(:subject, :with_document_type)
    expect(subject).to be_valid
  end

  context 'Validates' do
    it { is_expected.to validate_presence_of(:description) }
  end

  context 'Associations' do
    it { is_expected.to belong_to(:document_type) }
  end
end