class Document < ApplicationRecord
    has_one_attached :file
    include AASM
    acts_as_paranoid without_default_scope: true
    
    belongs_to :subject
    belongs_to :company_contact
    belongs_to :responsible, class_name: 'CompanyContact', foreign_key: 'responsible_id'

    attr_accessor :pdf_html
    validates :date, :company_contact_id, :subject_id, :responsible_id, presence: true

    before_create :generate_number
    before_create :generate_autentication
    after_create :generate_qrcode

    aasm column: :state do
        state :created, :initial => true
        state :completed

        event :complete, after_commit: :generate_document do
            transitions :from => :created, :to => :completed
        end
    end

    def contacts_to_dropdown
        self.company_contact.company.company_contacts
    end

    def generate_number
        ActiveRecord::Base.transaction do
            begin
                Document.select('COUNT(documents.id) as count').joins(subject:[:document_type]).where(year: Date.current.year).where('document_types.id = ?', self.subject.document_type_id).map do |document|
                self.number = document.count + 1
                end
                self.year = Date.current.year
            rescue => e
                ActiveRecord::Rollback
                raise e
            end
        end 
    end

    def generate_autentication
        salt = "docpr0j3ct" + rand(999999).to_s + Time.now.to_s +  self.date.to_s
        self.autentication = Digest::MD5.hexdigest(salt.upcase).upcase
    end

    def generate_qrcode
        require 'rqrcode'
        begin
            # Get own IP. OBS: Change to System URL
            qrcode = RQRCode::QRCode.new("http://#{Socket.ip_address_list.detect(&:ipv4_private?).try(:ip_address)}:3000/documents/validation/#{self.autentication}")
            png = qrcode.as_png(
                resize_gte_to: false,
                resize_exactly_to: false,
                fill: 'white',
                color: 'black',
                size: 400,
                border_modules: 4,
                module_px_size: 6,
                file: nil # path to write
            )
            png.save("public/qrcodes/document_#{self.id}.png")
        rescue Exception => e
            raise I18n.t('messages.rescue')
        end
    end

    def generate_document
        require 'tempfile'
        ActiveRecord::Base.transaction do
            begin
                pdf_string = WickedPdf.new.pdf_from_string(
                    self.pdf_html,
                    javascript_delay: 2,
                    page_size: 'A4'
                )

                tempfile = Tempfile.new("document.pdf")
                tempfile.binmode
                tempfile.write pdf_string
                tempfile.close

                self.issuance_date = DateTime.current
                self.file.attach(io: File.open(tempfile), filename: "document.pdf", content_type: "application/json")
                self.save

                tempfile.delete
            rescue => e
                ActiveRecord::Rollback
                puts e.inspect
                raise I18n.t('messages.rescue')
            end
        end
    end
end
