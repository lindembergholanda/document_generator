class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :trade_name
      t.string :cnpj
      t.timestamps
      t.timestamp :deleted_at
    end
  end
end
