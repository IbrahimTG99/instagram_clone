class User < ApplicationRecord
  include PgSearch::Model

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_]+\z/ }
  validates :first_name, presence: true, length: { minimum: 2, maximum: 20 }, format: { with: /\A[a-zA-Z]+\z/ }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 20 }, format: { with: /\A[a-zA-Z]+\z/ }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password_confirmation, presence: true

  has_many :posts, dependent: :destroy
  has_many :stories, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # 'follows' relationship objects where the user is being followed.
  has_many :follower_relationships, foreign_key: :following_id, class_name: :Follow, dependent: :destroy,
                                    inverse_of: :following
  # The next line goes the next step and accesses a user's followers through those relationships which are 'accepted'.
  has_many :followers, -> { Follow.accepted }, through: :follower_relationships

  #  same for the 'following' relationships
  has_many :following_relationships, foreign_key: :follower_id, class_name: :Follow, dependent: :destroy,
                                     inverse_of: :follower
  has_many :following, -> { Follow.accepted }, through: :following_relationships

  has_one_attached :avatar, dependent: :destroy
  after_commit :add_default_avatar, on: %i[create update]

  def liked?(post)
    likes.where(post_id: post.id).exists?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def follow(user_id)
    following_relationships.create(following_id: user_id)
    following = User.find(user_id)
    return true if following.private?

    following_relationships.find_by(following_id: user_id).update(status: 'accepted')
  end

  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end

  def following?(user_id)
    following.include?(User.find(user_id))
  end

  def pending?(user_id)
    @relationship = following_relationships.find_by(following_id: user_id)
    @relationship.status == 'pending' unless @relationship.nil?
  end

  def follower_count
    followers.count
  end

  def following_count
    following_relationships.count
  end

  def self.text_search(query)
    if query.present?
      where('username ILIKE ?', "%#{query}%")
    else
      all
    end
  end

  private

  def add_default_avatar
    return if avatar.attached?

    avatar.attach(
      io: File.open(Rails.root.join('app/assets/images/default_profile.jpg')),
      filename: 'default_profile.jpg',
      content_type: 'image/jpg'
    )
  end
end
