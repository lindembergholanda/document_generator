class CompanyAddress < ApplicationRecord
    acts_as_paranoid without_default_scope: true

    belongs_to :company, inverse_of: :company_address
    belongs_to :city

    validates :street_address, :number, :zip_code, :city_id, :company_id, presence: true
end