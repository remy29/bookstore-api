class CreateBookstores < ActiveRecord::Migration[6.0]
  def change
    create_table :bookstores do |t|
      t.string :name, null: false
      t.string :address, null: false

      t.timestamps
    end
  end
end
