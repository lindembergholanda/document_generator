class Company < ApplicationRecord
    acts_as_paranoid without_default_scope: true
    
    has_many :company_address, inverse_of: :company, dependent: :destroy
    has_many :company_contacts, inverse_of: :company, dependent: :destroy

    validates :name, :trade_name, :cnpj, presence: true
    validate :validate_cnpj, unless: Proc.new { |company| company.cnpj.blank? }

    accepts_nested_attributes_for :company_address, allow_destroy: true, reject_if: proc { |attributes| not attributes['id'].blank? }
    accepts_nested_attributes_for :company_contacts, allow_destroy: true, reject_if: proc { |attributes| not attributes['id'].blank? }

    def validate_cnpj
        self.errors.add(:cnpj, I18n.t('errors.messages.invalid')) unless ValidateCnpj.valid? self.cnpj
    end
end
