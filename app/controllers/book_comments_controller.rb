class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.build(book_comment_params)
    @book_comment.user_id = current_user.id
    if @book_comment.save
      respond_to do |format|
        format.html { redirect_to book_path(@book) }
        format.js
      end
    else
      redirect_to book_path(@book)
    end
  end

  def destroy
    @book_comment = BookComment.find(params[:id])
    @comment_id = @book_comment.id
    @book = @book_comment.book
    if @book_comment.user_id == current_user.id
      @book_comment.destroy
      respond_to do |format|
        format.html { redirect_to book_path(@book) }
        format.js
      end
    else
      redirect_to book_path(@book)
    end
  end

   private
  def book_comment_params
    params.require(:book_comment).permit(:content)
  end
end
