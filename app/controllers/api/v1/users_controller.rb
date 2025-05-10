class Api::V1::UsersController < ApplicationController
    def index
        users = User
            .includes(:followees, :followers)
            .map do |user|
                {
                    id: user.id,
                    name: user.name,
                    image: user.image,
                    followeesCount: user.followees.size,
                    followersCount: user.followers.size
                }
            end

        render json: {
            users: users,
            total: User.count
        }
    end
end
