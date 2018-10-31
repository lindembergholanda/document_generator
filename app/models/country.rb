class Country < ApplicationRecord
    acts_as_paranoid without_default_scope: true

    has_many :states, dependent: :restrict_with_error

    validates :name, presence: true
end
