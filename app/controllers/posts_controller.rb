class PostsController < ApplicationController
  def new 
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was succesfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])

    @post.cover_photo.attach(params[:avatar])

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end 
  end
  
  def guides
    @guides = Post.guide.with_attached_cover_photo
    # fetch_instagram
  end

  def reviews
    @reviews = Post.review.with_attached_cover_photo
  end

  def interviews
    @interviews = Post.interview.with_attached_cover_photo
  end

  def food
    @food_posts = Post.not_interview
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_food_path, notice: "Post was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category, :cover_photo, :tag_list)
  end

  def show_params
    params.require(:comment).permit(:text, :post_id)
  end

  def fetch_instagram
    @instagram_user = InstagramClient.new.user(@user.antwerpfoosta)
  end
end