class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create 
    @post = Post.find(new_params[:post_id])
    @comment = current_user.comments.build(new_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comment was succesfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @comment = Comment.find(edit_params[:id])
  end
  
  def update
    @comment = Comment.find(edit_params[:id])
    @post = Post.find(@comment.post_id)

    if @comment.update(edit_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end 
  end

  def destroy
    @comment = Comment.find(destroy_params[:id])
    @post = Post.find(destroy_params[:post])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @post, notice: "Comment was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  def new_params 
    params.require(:comment).permit(:text, :post_id)
  end

  def destroy_params
    params.permit(:post, :id)
  end

  def edit_params 
    params.permit(:id)
  end
end
