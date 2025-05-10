require 'faker'
require 'open-uri'
require 'set'

def fetch_markdown_content
  URI.open('https://jaspervdj.be/lorem-markdownum/markdown.txt').read
rescue OpenURI::HTTPError => e
  puts "Failed to fetch markdown content: #{e.message}"
  ""
end

puts "Seeding users..."
users = 10.times.map do
  User.create!(
    id: SecureRandom.uuid,
    name: Faker::Name.name,
    image: Faker::Avatar.image
  )
end

puts "Seeding blogs..."
blogs = 30.times.map do
  Blog.create!(
    id: SecureRandom.uuid,
    title: Faker::Lorem.sentence,
    content: fetch_markdown_content,
    is_published: Faker::Boolean.boolean,
    created_at: Faker::Date.backward(days: 365),
    author: users.sample
  )
end

puts "Seeding bookmarks..."
bookmark_set = Set.new

until bookmark_set.size >= 60
  user = users.sample
  blog = blogs.sample
  key = [ user.id, blog.id ]
  bookmark_set.add(key)
end

bookmark_set.each do |user_id, blog_id|
  Bookmark.create!(
    id: SecureRandom.uuid,
    user_id: user_id,
    blog_id: blog_id
  )
end

puts "Seeding relationships..."
relationship_set = Set.new

until relationship_set.size >= 30
  followee = users.sample
  follower = users.sample
  next if followee == follower

  key = [ followee.id, follower.id ]
  relationship_set.add(key)
end

relationship_set.each do |followee_id, follower_id|
  Relationship.create!(
    id: SecureRandom.uuid,
    followee_id: followee_id,
    follower_id: follower_id
  )
end

puts "✅ Seeding completed!"
