class ChangeDefaultForIsPublished < ActiveRecord::Migration[8.0]
  def change
    change_column_default :blogs, :is_published, from: nil, to: true
  end
end
