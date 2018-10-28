class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.string :description
      t.text :text
      t.integer :document_type_id
      t.timestamp :deleted_at

      t.timestamps
    end
    add_foreign_key :subjects, :document_types, :name =>"fk_subjects_document_types_id", column:  :document_type_id
  end
end
