class Blog < ApplicationRecord
    belongs_to :author, class_name: "User", foreign_key: :author_id, inverse_of: :blogs

    has_many :bookmarks, dependent: :destroy
    has_many :bookmarking_users, through: :bookmarks, source: :user
end
