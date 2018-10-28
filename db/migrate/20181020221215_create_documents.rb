class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.integer :number
      t.integer :year
      t.text :text
      t.datetime :date
      t.integer :subject_id
      t.integer :company_contact_id
      t.integer :responsible_id
      t.string :autentication
      t.datetime :issuance_date
      t.string :state
      t.timestamps
      t.timestamp :deleted_at
    end
    add_foreign_key :documents, :company_contacts, :name =>"fk_documents_company_contacts_id", column:  :company_contact_id
    add_foreign_key :documents, :company_contacts, :name =>"fk_documents_responsible_id_company_contacts_id", column:  :responsible_id
  end
end
