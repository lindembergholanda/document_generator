class DocumentType < ApplicationRecord
    acts_as_paranoid without_default_scope: true

     validates :description, presence: true
end
