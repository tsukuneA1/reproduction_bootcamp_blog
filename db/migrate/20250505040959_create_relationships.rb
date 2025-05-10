class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships, id: :string do |t|
      t.string :followee_id, null: false
      t.string :follower_id, null: false

      t.timestamps
    end

    add_index :relationships, [ :followee_id, :follower_id ], unique: true
  end
end
