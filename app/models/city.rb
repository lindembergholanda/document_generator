class City < ApplicationRecord
    acts_as_paranoid without_default_scope: true

    has_many :company_address, dependent: :restrict_with_error
    belongs_to :state

    validates :name, :state_id, presence: true
    validates :capital, inclusion: { in: [ true, false ], message: I18n.t('errors.messages.blank') }
end
