class Api::V1::BlogsController < ApplicationController
  before_action :set_first_user, only: [ :create ]

  def index
    blogs = Blog.where(is_published: true)
                .includes(:author, :bookmarks)
                .order(created_at: :desc)
                .map do |blog|
      blog.as_json(
        only: [ :id, :title, :content, :created_at, :updated_at, :is_published ]
      ).merge(
        bookmark_count: blog.bookmarks.size,
        author: {
          name: blog.author.name,
          image: blog.author.image
        }
      )
    end

    sorted_blogs = blogs.sort_by { |b| -b[:bookmark_count] }

    render json: {
      blogs: sorted_blogs,
      total: Blog.count
    }
  end

  def create
  title = params[:title]
  content = params[:content]

  if title.blank? || content.blank?
    return render json: { error: "Title and content are required." }, status: :bad_request
  end

  blog = Blog.new(
    id: SecureRandom.uuid,
    title: title,
    content: content,
    author_id: @first_user.id,
    is_published: true
  )

  if blog.save
    render json: {
      id: blog.id,
      title: blog.title,
      content: blog.content,
      is_published: blog.is_published,
      created_at: blog.created_at,
      author: {
        name: blog.author.name,
        image: blog.author.image
      }
    }, status: :created
  else
    render json: { error: blog.errors.full_messages }, status: :unprocessable_entity
  end
end


  def show
    blog = Blog.includes(:author).find_by(id: params[:id], is_published: true)
    if blog.nil?
      render json: { error: "Not found" }, status: :not_found
    else
      render json: {
        id: blog.id,
        title: blog.title,
        content: blog.content,
        is_published: blog.is_published,
        created_at: blog.created_at,
        author: {
          name: blog.author.name,
          image: blog.author.image
        }
      }
    end
  end

  private

  def set_first_user
    @first_user = User.first || User.create!(
      name: "default_user",
      image: "https://placehold.jp/150x150.png"
    )
  end
end
