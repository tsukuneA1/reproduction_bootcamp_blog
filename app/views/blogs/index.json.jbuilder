json.total Blog.count
json.blogs @blogs do |blog|
  json.partial! "blogs/blog", blog: blog
end
