class City < ApplicationRecord
    acts_as_paranoid without_default_scope: true

    has_many :company_address, dependent: :restrict_with_error
    belongs_to :state

    validates :name, :capital, :state_id, presence: true
end
