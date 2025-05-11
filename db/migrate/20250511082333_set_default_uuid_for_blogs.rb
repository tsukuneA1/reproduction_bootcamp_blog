class SetDefaultUuidForBlogs < ActiveRecord::Migration[8.0]
  def change
    change_column_default :blogs, :id, -> {"gen_random_uuid()"}
  end
end
