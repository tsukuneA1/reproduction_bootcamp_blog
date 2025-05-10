class User < ApplicationRecord
    has_many :blogs, foreign_key: :author_id, inverse_of: :author, dependent: :destroy

    has_many :bookmarks, dependent: :destroy
    has_many :bookmarked_blogs, through: :bookmarks, source: :blog

    has_many :followee_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
    has_many :followees, through: :followee_relationships, source: :followee

    has_many :follower_relationships, class_name: "Relationship", foreign_key: :followee_id, dependent: :destroy
    has_many :followers, through: :follower_relationships, source: :follower
end
