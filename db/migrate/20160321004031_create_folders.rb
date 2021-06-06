class CreateFolders < ActiveRecord::Migration[4.2]
  def change
    create_table :folders do |t|
      t.string :name
      t.string :image
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
