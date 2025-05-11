json.id @blog.id
json.title @blog.title
json.content @blog.content
json.is_published @blog.is_published
json.created_at @blog.created_at

json.author do
  json.name @blog.author.name
  json.image @blog.author.image
end
