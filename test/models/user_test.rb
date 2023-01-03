require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.create(username: 'tester123', first_name: 'Example', last_name: 'User', email: 'test12@testing.com', password: 'password', password_confirmation: 'password')
    @user2 = User.create(username: 'tester1234', first_name: 'Example', last_name: 'User', email: 'test21@testing.com', password: 'password', password_confirmation: 'password', private: false)
  end

  context "associations" do
    should have_one_attached(:avatar)
    should have_many(:followers)
    should have_many(:following)
    should have_many(:follower_relationships)
    should have_many(:following_relationships)
    should have_many(:stories)
    should have_many(:comments)
    should have_many(:posts)
    should have_many(:likes)
  end

  context "validations" do
    should validate_presence_of(:username)
    should validate_uniqueness_of(:username)
    should allow_value('username123').for(:username)
    should validate_presence_of(:email)
    should validate_uniqueness_of(:email).case_insensitive
    should validate_presence_of(:password)
    should validate_presence_of(:password_confirmation)
    should validate_length_of(:password).is_at_least(6)
    should validate_presence_of(:first_name)
    should validate_length_of(:first_name).is_at_least(3)
    should validate_length_of(:first_name).is_at_most(20)
    should allow_value('firstname').for(:first_name)
    should validate_presence_of(:last_name)
    should validate_length_of(:last_name).is_at_least(3)
    should validate_length_of(:last_name).is_at_most(20)
    should allow_value('lastname').for(:last_name)
  end

  context "methods" do
    should "return full name" do
      assert_equal "Example User", @user.full_name
    end
  end

  # context "callbacks" do
  #   should "add default avatar if none is attached" do
  #
  #     assert_equal "default_profile.jpg", @user.avatar.filename.to_s
  #   end
  # end

  # context "following" do
  #   should "return users who are being followed" do
  #     @user.follow(@user2.id)
  #     assert_equal [@user2], @user.following
  #   end
  # end

  # context "followers" do
  #   should "return users who are following" do
  #     @user.follow(@user2.id)
  #     assert_equal [@user], @user2.followers
  #   end
  # end

  # context "follow" do
  #   should "follow a user" do
  #     @user.follow(@user2.id)
  #     assert_equal [@user2], @user.following
  #   end
  # end

  # context "unfollow" do
  #   should "unfollow a user" do
  #     @user.follow(@user2.id)
  #     @user.unfollow(@user2.id)
  #     assert_equal [], @user.following
  #   end
  # end

  # context "following?" do
  #   should "return true if user is following" do
  #     @user.follow(@user2.id)
  #     assert @user.following?(@user2.id)
  #   end
  # end

end
