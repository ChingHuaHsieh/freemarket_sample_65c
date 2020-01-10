class CommentsController < ApplicationController
  before_action :set_product

  def create
    @comment = @product.comments.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to product_path(@product) }
        format.json
      end
    else
      @comment = @product.comments.includes(:user)
      render product_path(@product)
    end
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    @comment.update(text: "出品者がコメントを削除しました")
    redirect_to "/products/#{@product.id}"
  end

  private
  
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, product_id: params[:product_id])
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end