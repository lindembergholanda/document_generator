class Company < ApplicationRecord
    acts_as_paranoid without_default_scope: true
    
    has_many :company_address, dependent: :restrict_with_error
    has_many :company_contact, dependent: :restrict_with_error

    validates :name, :trade_name, :cnpj, presence: true

    accepts_nested_attributes_for :company_address, allow_destroy: true, reject_if: proc { |attributes| not attributes['id'].blank? }
    accepts_nested_attributes_for :company_contact, allow_destroy: true, reject_if: proc { |attributes| not attributes['id'].blank? }
end
