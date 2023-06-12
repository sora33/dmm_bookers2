class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :viewcounts, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def self.popular_in_past_week
    self.joins(:favorites)
        .select('books.*, COUNT(favorites.id) AS favorites_count')
        .where('favorites.created_at >= ?', 1.week.ago)
        .group('books.id')
        .order('favorites_count DESC')
  end
end
