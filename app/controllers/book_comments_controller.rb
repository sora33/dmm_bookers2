class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = @book.book_comments.build(book_comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to book_path(@book)
    else
      redirect_to book_path(@book)
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @comment = @book.book_comments.find(params[:id])
    if current_user == @comment.user
      @comment.destroy
      redirect_to book_path(@book)
    else
      redirect_to book_path(@book)
    end
  end

   private
  def book_comment_params
    params.require(:book_comment).permit(:content)
  end
end
