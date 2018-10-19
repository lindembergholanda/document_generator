class State < ApplicationRecord
    acts_as_paranoid without_default_scope: true

    has_many :cities, dependent: :restrict_with_error
    belongs_to :country

    validates :name, :short_name, presence: true

end
