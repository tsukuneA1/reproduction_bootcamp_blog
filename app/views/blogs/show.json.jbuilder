json.id @blog.id
json.title @blog.title
json.content @blog.content
json.author do
  json.id @blog.author.id
  json.name @blog.author.name
  json.image @blog.author.image
end
