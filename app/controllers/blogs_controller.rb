class BlogsController < ApplicationController
  before_action :set_first_user, only: [:create]

  def index
    @blogs = Blog.where(is_published: true)
                 .includes(:author, :bookmarks)
                 .order(created_at: :desc)
                 .sort_by { |b| -b.bookmarks.size }
  end

  def create
    title = params[:title]
    content = params[:content]

    if title.blank? || content.blank?
      return render json: { error: "Title and content are required." }, status: :bad_request
    end

    @blog = Blog.new(blog_params.merge(
      author_id: @first_user.id,
    ))

    if @blog.save
      render :create, status: :created
    else
      render json: { error: @blog.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @blog = Blog.includes(:author).find_by(id: params[:id], is_published: true)
    if @blog.nil?
      render json: { error: "Not found" }, status: :not_found
    else
      render :show
    end
  end

  private

  def set_first_user
    @first_user = User.first || User.create!(
      name: "default_user",
      image: "https://placehold.jp/150x150.png"
    )
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :is_published)
  end
end
