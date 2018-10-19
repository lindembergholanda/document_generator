class CreateCompanyAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :company_addresses do |t|
      t.string :street_address
      t.integer :number
      t.integer :city_id
      t.string :zip_code
      t.integer :company_id
      t.timestamps
      t.timestamp :deleted_at
    end
    add_foreign_key :company_addresses, :cities, :name =>"fk_company_addresses_cities_id", column:  :city_id
    add_foreign_key :company_addresses, :companies, :name =>"fk_company_addresses_companies_id", column:  :company_id
  end
end
