class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @viewcount = Viewcount.find_or_initialize_by(user: current_user, book: @book)
    if @viewcount.new_record?
      @viewcount.save!
    end
    @new_book = Book.new
  end

  def index
    @book = Book.new
    @books = Book.popular_in_past_week
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
