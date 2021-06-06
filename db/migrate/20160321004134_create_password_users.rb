class CreatePasswordUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :password_users do |t|
      t.references :password, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :permissions

      t.timestamps null: false
    end
  end
end
