class CreatePasswords < ActiveRecord::Migration[4.2]
  def change
    create_table :passwords do |t|
      t.string :name
      t.string :login
      t.string :pass
      t.string :url
      t.text :notes
      t.string :image
      t.references :folder, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
