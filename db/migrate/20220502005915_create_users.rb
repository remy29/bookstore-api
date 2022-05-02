class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.string :permission_level

      t.timestamps
    end
  end
end
