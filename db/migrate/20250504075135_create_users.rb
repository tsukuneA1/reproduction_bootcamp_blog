class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :string do |t|
      t.string :name, null: false, unique: true
      t.string :image

      t.timestamps
    end
  end
end
