class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :likes

  def full_name
    "#{first_name} #{last_name}"
  end

  def following
    0
  end

  def followers
    0
  end
end
