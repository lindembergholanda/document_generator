class Country < ApplicationRecord
    acts_as_paranoid without_default_scope: true

    has_many :cities, dependent: :restrict_with_error

    validates :name, presence: true
end
