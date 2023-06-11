module FavoritesHelper
  def favorite_icon(book)
    if current_user.favoriting?(book)
      link_to(book_favorites_path(book), method: :delete, class: 'text-danger') do
        concat(content_tag(:i, '', class: 'fas fa-heart'))
        concat(" ")
        concat(book.favorites.count)
      end
    else
      link_to(book_favorites_path(book), method: :post, class: 'text-primary') do
        concat(content_tag(:i, '', class: 'far fa-heart'))
        concat(" ")
        concat(book.favorites.count)
      end
    end
  end
end
