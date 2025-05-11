json.total @users.size

json.users @users do |user|
    json.id user.id
    json.name user.name
    json.image user.image
    json.followees_count user.followees.size
    json.followers_count user.followers.size
end
