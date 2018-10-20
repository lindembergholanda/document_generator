class CreateDocumentTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :document_types do |t|
      t.string :description
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
