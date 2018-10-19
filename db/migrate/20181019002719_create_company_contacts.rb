class CreateCompanyContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :company_contacts do |t|
      t.string :name
      t.string :occupation
      t.string :email
      t.integer :company_id
      t.timestamps
      t.timestamp :deleted_at
    end
    add_foreign_key :company_contacts, :companies, :name =>"fk_company_contacts_companies_id", column:  :company_id
  end
end
