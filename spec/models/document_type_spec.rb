require 'rails_helper'

RSpec.describe DocumentType, type: :model do
 it 'is valid with params' do
    document_type = create(:document_type)
    expect(document_type).to be_valid
  end

  context 'Validates' do
    it { is_expected.to validate_presence_of(:description) }
  end

  context 'Associations' do
    it { is_expected.to have_many(:subjects) }
  end
end