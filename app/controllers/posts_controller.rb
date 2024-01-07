class PostsController < ApplicationController

  before_action :authenticate_user, except: [:index, :show]

  def index
    @posts = Post.all
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


