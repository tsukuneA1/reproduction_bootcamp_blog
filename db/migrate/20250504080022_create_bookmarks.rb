class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks, id: :string do |t|
      t.string :user_id, null: false
      t.string :blog_id, null: false

      t.timestamps
    end

    add_index :bookmarks, [ :user_id, :blog_id ], unique: true
  end
end
