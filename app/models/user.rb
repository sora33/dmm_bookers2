class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :active_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :conversations, ->(user) { unscope(:where).where("user1_id = :id OR user2_id = :id", id: user.id) }
  has_many :messages, foreign_key: :sender_id

  has_many :viewcounts

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 200}

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  # いいねに関するメソッド
  def favoriting?(book)
    favorites.find_by(book_id: book.id).present?
  end

   # フォローに関するメソッド
  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  # DMに関するメソッド
  def conversations
    Conversation.where(sender_id: id).or(Conversation.where(recipient_id: id))
  end

  def find_conversation_with(other_user)
    conversations.where(sender: other_user).or(conversations.where(recipient: other_user)).first
  end

  def find_or_create_conversation_with(other_user)
    Conversation.between(id, other_user.id).first ||
      Conversation.find_or_create_by(sender_id: id, recipient_id: other_user.id)
  end

  def mutual_follow?(other_user)
    self.following?(other_user) && other_user.following?(self)
  end

end
