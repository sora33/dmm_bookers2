module FavoritesHelper
  def favorite_icon(book)
    if current_user.favoriting?(book)
      link_to(book_favorites_path(book), method: :delete, remote: true, class: 'text-danger favorite-btn', id: "favorite-btn-#{book.id}") do
        concat(content_tag(:i, '', class: 'fas fa-heart'))
        concat(" ")
        concat(book.favorites.count)
      end
    else
      link_to(book_favorites_path(book), method: :post, remote: true, class: 'text-primary favorite-btn', id: "favorite-btn-#{book.id}") do
        concat(content_tag(:i, '', class: 'far fa-heart'))
        concat(" ")
        concat(book.favorites.count)
      end
    end
  end
end
