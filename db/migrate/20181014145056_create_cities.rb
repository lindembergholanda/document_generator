class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :name
      t.boolean :capital
      t.integer :state_id
      t.timestamps
      t.timestamp :deleted_at
    end
    add_foreign_key :cities, :states, :name =>"fk_cities_states_id", column:  :state_id
  end
end
