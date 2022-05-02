class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.string :isbn, null: false
      t.string :last_edited_by
      t.integer :status, null: false
      t.integer :stock, null: false

      t.timestamps
    end
  end
end
