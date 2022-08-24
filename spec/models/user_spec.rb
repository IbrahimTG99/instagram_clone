require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, private: true) }
  let(:user2) { create(:user) }

  describe 'associations' do
    it { should have_many(:posts)}
    it { should have_many(:stories)}
    it { should have_many(:likes)}
    it { should have_many(:comments)}
    it { should have_many(:follower_relationships).class_name('Follow').with_foreign_key('following_id').inverse_of(:following) }
    it { should have_many(:followers).through(:follower_relationships) }
    it { should have_many(:following_relationships).class_name('Follow').with_foreign_key('follower_id').inverse_of(:follower) }
    it { should have_many(:following).through(:following_relationships) }
    it { should have_one_attached(:avatar)}
  end

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should allow_value('a_username').for(:username) }
    it { should_not allow_value('a!username ').for(:username) }

    it { should validate_presence_of(:first_name) }
    it { should allow_value('first').for(:first_name) }
    it { should_not allow_value('first!').for(:first_name) }
    it { should validate_length_of(:first_name).is_at_least(2).is_at_most(20) }

    it { should validate_presence_of(:last_name) }
    it { should allow_value('last').for(:last_name) }
    it { should_not allow_value('last!').for(:last_name) }
    it { should validate_length_of(:last_name).is_at_least(2).is_at_most(20) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('test1@testing.com').for(:email)}
    it { should_not allow_value('t!est1/@testing').for(:email)}

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }

    it { should validate_presence_of(:password_confirmation)}
  end


  context 'methods' do
    it 'returns full name' do
      expect(user.full_name).to eq([user.first_name, user.last_name].join(' '))
    end

    describe '.text_search' do
      it 'returns the user who we are searching for' do
        expect(User.text_search(user.username).first.username).to eq(user.username)
      end

      it 'returns all users if no query is provided' do
        expect(User.text_search('').count).to eq(User.count)
      end
    end
  end

  context 'methods where user follows and interacts with other users posts' do
    let(:post) { create(:post, user: user2) }
    let!(:like) { create(:like, user: user2, post: post) }

    describe '#follow' do
      it 'follows another user' do
        expect(user.follow(user2.id)).to eq(true)
      end
    end

    describe '#liked?' do
      it 'returns false if user has not liked a post' do
        expect(user.liked?(post)).to eq(false)
      end

      it 'returns true if user has liked a post' do
        expect(user2.liked?(post)).to eq(true)
      end
    end

    it 'returns false if user has not liked a post' do
      like.destroy
      expect(user.liked?(post)).to eq(false)
    end
  end

  context 'methods where user is following another user' do
    before do
      user.follow(user2.id)
    end

    describe '#following?' do
      it 'returns true if user is following another user' do
        expect(user.following?(user2.id)).to eq(true)
      end

      it 'returns false if user is not following another user' do
        expect(user2.following?(user.id)).to eq(false)
      end
    end

    describe '#pending?' do
      it 'returns true if user is pending another user' do
        user2.follow(user.id)
        expect(user2.pending?(user.id)).to eq(true)
      end

      it 'returns false if user is not pending another user' do
        expect(user.pending?(user2.id)).to eq(false)
      end
    end

    describe '#follower_count' do
      it 'returns the count of followers' do
        expect(user2.follower_count).to eq(1)
      end
    end

    describe '#following_count' do
      it 'returns the count of following' do
        expect(user.following_count).to eq(1)
      end
    end

    describe '#unfollow' do
      it 'unfollows another user' do
        expect(user.unfollow(user2.id)).to be_kind_of(Follow)
      end
    end
  end

  describe 'callback methods' do
    it 'creates a default avatar if user has no avatar' do
      expect(user.avatar.attached?).to eq(true)
    end
  end
end
