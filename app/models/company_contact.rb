class CompanyContact < ApplicationRecord
    acts_as_paranoid without_default_scope: true

    belongs_to :company, inverse_of: :company_contacts
    has_many :documents, dependent: :restrict_with_error
    has_many :responsibles, class_name: 'Document', foreign_key: 'responsible_id', dependent: :restrict_with_error

    validates :personal_title, :name, :occupation, :sector, presence: true

    scope :senders, -> { where(send_document: true) }

    def send_document_description
        self[:send_document] ? I18n.t('helpers.links.yess') : I18n.t('helpers.links.noo')
    end

    def text_dropdown_responsibles
        "#{self.name} - #{self.occupation} - #{self.sector} - #{self.company.trade_name}"
    end

end
