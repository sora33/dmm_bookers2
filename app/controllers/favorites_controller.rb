class FavoritesController < ApplicationController
  def create
    @favorite = current_user.favorites.create(book_id: params[:book_id])
    @book = @favorite.book
    respond_to do |format|
      format.html { redirect_to request.referer || root_url }
      format.js
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @favorite = current_user.favorites.find_by(book_id: @book.id)
    @favorite.destroy
    respond_to do |format|
      format.html { redirect_to request.referer || root_url }
      format.js
    end
  end
end
