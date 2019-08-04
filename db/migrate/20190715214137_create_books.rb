class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :book_desc
      t.integer :user_id
      t.string :book_title
      t.string :author_name
    end
  end
end
