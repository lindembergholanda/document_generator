class DocumentType < ApplicationRecord
    acts_as_paranoid without_default_scope: true

    has_many :subjects, dependent: :restrict_with_error

    validates :description, presence: true
end
