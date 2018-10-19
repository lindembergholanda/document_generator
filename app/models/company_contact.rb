class CompanyContact < ApplicationRecord
    acts_as_paranoid without_default_scope: true

    belongs_to :company

    validates :name, :occupation, presence: true
end
