class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :book_tittle
      t.string :author
      t.string :hashname
      t.string :image
      t.integer :topic_id

      t.timestamps
    end
  end
end
