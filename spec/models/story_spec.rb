require 'rails_helper'

RSpec.describe Story, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_one_attached(:image) }
  end

  describe 'validations' do
    context 'when image is not attached' do
      it 'raises error if image is not attached' do
        expect { create(:story) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when image is attached' do
      it 'raises error if image is not png or jpg' do
        fake_img = fixture_file_upload('spec/fixtures/images/test.txt', 'text/plain')
        story = build(:story, image: fake_img)
        expect(story).to_not be_valid
      end

      it 'is valid if image is png or jpg' do
        img = fixture_file_upload('spec/fixtures/images/test.jpg', 'image/jpg')
        story = build(:story, image: img, user: user)
        expect(story).to be_valid
      end
    end
  end

  describe 'scopes' do
    context 'of followed users' do
      it 'returns stories followed by the current user' do
        create(:follow, follower: other_user, following: user)
        expect(Story.of_followed_users(other_user)).to eq(user.stories)
      end
    end
  end
end
