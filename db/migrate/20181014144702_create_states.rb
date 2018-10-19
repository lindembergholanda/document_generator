class CreateStates < ActiveRecord::Migration[5.2]
  def change
    create_table :states do |t|
      t.string :name
      t.string :short_name
      t.integer :country_id
      t.timestamps
      t.timestamp :deleted_at
    end
    add_foreign_key :states, :countries, :name =>"fk_states_countries_id", column:  :country_id
  end
end
