class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:id])
    comment = current_user.comment.new(comment_params)
    comment.book_id = book.id
    comment.save
    redirect_to request.referer
  end
  
  def destroy
    comment = BookComment.find(params[:id])
    comment.destroy
    redirect_to request.referer
  end
  
  private
  
  def comment_params
    params.require(:book_comment).permit(:comment)
  end
end
