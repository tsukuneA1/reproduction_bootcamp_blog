class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs, id: :string do |t|
      t.string :author_id, null: false
      t.string :title
      t.text :content
      t.boolean :is_published, default: false

      t.timestamps
    end

    add_index :blogs, :author_id
  end
end
