class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = book.id
    @comment.save
    responce = {
      id: @comment.id,
      comment: @comment.comment,
      date: @comment.created_at.strftime('%Y/%m/%d'),
      book_id: @comment.book_id,
      user_name: @comment.user.name
    }
    respond_to do |format|
      format.html { redirect_to book_path(book) }
      format.json { render json: responce }
    end
  end

  def destroy
    BookComment.find(params[:id]).destroy
    redirect_to book_path(params[:book_id])
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
