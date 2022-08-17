class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

<<<<<<< Updated upstream
=======
  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_]+\z/ }
  validates :first_name, presence: true, length: { minimum: 3, maximum: 20 }, format: { with: /\A[a-zA-Z]+\z/ }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 20 }, format: { with: /\A[a-zA-Z]+\z/ }
  validates :email, presence: true, uniqueness: true

>>>>>>> Stashed changes
  has_many :posts, dependent: :destroy
  has_many :stories, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  # 'follows' relationship objects where the user is being followed.
  has_many :follower_relationships, foreign_key: :following_id, class_name: :Follow, dependent: :destroy,
                                    inverse_of: :following
<<<<<<< Updated upstream
  # The next line goes the next step and accesses a user's followers through those relationships
  has_many :followers, through: :follower_relationships, source: :follower
  #  for the 'following' relationships
  has_many :following_relationships, foreign_key: :follower_id, class_name: :Follow, dependent: :destroy,
                                     inverse_of: :follower
  has_many :following, through: :following_relationships, source: :following
=======
  # The next line goes the next step and accesses a user's followers through those relationships which are 'accepted'.
  has_many :followers, -> { Follow.accepted }, through: :follower_relationships

  #  same for the 'following' relationships
  has_many :following_relationships, foreign_key: :follower_id, class_name: :Follow, dependent: :destroy,
                                     inverse_of: :follower
  has_many :following, -> { Follow.accepted }, through: :following_relationships

>>>>>>> Stashed changes
  has_one_attached :avatar, dependent: :destroy
  after_commit :add_default_avatar, on: %i[create update]

  def liked?(post)
    likes.where(post_id: post.id).exists?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: '150x150')
    else
      'default_profile.jpg'
    end
  end

  def follow(user_id)
    following_relationships.create(following_id: user_id)
<<<<<<< Updated upstream
=======
    following = User.find(user_id)
    return true if following.private?

    following_relationships.find_by(following_id: user_id).update(status: 'accepted')
>>>>>>> Stashed changes
  end

  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end

  def following?(user_id)
    following_relationships.where(following_id: user_id).exists?
  end

  def follower_count
    follower_relationships.count
  end

  def following_count
    following_relationships.count
  end

  private

  def add_default_avatar
    return if avatar.attached?

    avatar.attach(
      io: File.open(Rails.root.join('default_profile.jpg')),
      filename: 'default_profile.jpg',
      content_type: 'image/jpg'
    )
  end
end
