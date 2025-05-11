class UsersController < ApplicationController
    def index
        @users = User.includes(:followees, :followers)
        render :index
    end
end
