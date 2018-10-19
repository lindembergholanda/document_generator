class CompanyAddress < ApplicationRecord
    acts_as_paranoid without_default_scope: true

    belongs_to :company
end
