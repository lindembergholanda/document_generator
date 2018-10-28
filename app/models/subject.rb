class Subject < ApplicationRecord
    acts_as_paranoid without_default_scope: true
    
    belongs_to :document_type
end
