class PostsController < ApplicationController

  before_action :authenticate_user, except: [:index, :show]

  def index
    followed_user_ids = current_user.following.pluck(:id)
    user_post_ids = current_user.posts.pluck(:id)
    followed_posts = Post.where(user_id: followed_user_ids)
    user_posts = Post.where(id: user_post_ids)

    @posts = (user_posts + followed_posts).uniq.sort_by(&:created_at).reverse
    render :index
  end

  def show
    @post = Post.find_by(id: params[:id])
    render :show
  end

  def create
    post = Post.new(
      user_id: current_user.id,
      text: params[:text],
    )
    if post.save
      render json: post
    else
      render json: { errors: post.errors.full_messages }, status: :bad_request
    end
  end

  def update
    post = Post.find_by(id: params[:id])
    post.user_id = params[:user_id] || post.user_id
    post.text = params[:text] || post.text
    if post.save
      render json: post
    else
      render json: { errors: post.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    post = Post.find_by(id: params[:id])
    post.destroy
    render json: { message: "Post successfully destroyed!" }
  end

end


