require 'rails_helper'

RSpec.describe Post, type: :model do

  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:likes) }
    it { should have_many(:comments) }
    it { should have_many_attached(:images) }
  end

  describe 'validations' do

    it { should validate_presence_of(:user_id) }

    context 'when image is not attached' do
      it 'raises error if images is not attached' do
        expect { create(:post, images: []) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when image is attached' do
      it 'raises error if images are not png or jpg' do
        fake_img = fixture_file_upload('spec/fixtures/images/test.txt', 'text/plain')
        post = build(:post, images: [fake_img])
        expect(post).to_not be_valid
      end

      it 'is valid if images are png or jpg' do
        img = fixture_file_upload('spec/fixtures/images/test.jpg', 'image/jpg')
        post = build(:post, user:  user, images: [img])
        expect(post).to be_valid
      end
    end
  end

  describe 'scopes' do
    context 'of followed users' do
      it 'returns posts followed by the current user' do
        create(:follow, follower: other_user, following: user)
        expect(Post.of_followed_users(other_user)).to eq(user.posts)
      end
    end
  end
end
