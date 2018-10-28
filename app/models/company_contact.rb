class CompanyContact < ApplicationRecord
    acts_as_paranoid without_default_scope: true

    belongs_to :company

    validates :personal_title, :name, :occupation, :sector presence: true

    scope :senders, -> { where(send_document: true) }

    def send_document_description
        self[:send_document] ? I18n.t('helpers.links.yess') : I18n.t('helpers.links.noo')
    end

    def text_dropdown_responsibles
        "#{self.name} - #{self.occupation} - #{self.sector} - #{self.company.trade_name}"
    end

end
