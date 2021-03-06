class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.references :bookstore, index: true, foreign_key: true
      t.string :title, null: false
      t.string :author, null: false
      t.string :isbn, null: false
      t.integer :status, null: false
      t.integer :stock, null: false

      t.timestamps
    end
  end
end
