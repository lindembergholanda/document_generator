class City < ApplicationRecord
    acts_as_paranoid without_default_scope: true

    has_many :states, dependent: :restrict_with_error
    belongs_to :country

    validates :name, :capital, :state_id, presence: true
end
