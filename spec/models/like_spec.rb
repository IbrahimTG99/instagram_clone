require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'validations' do
    it 'raises error if post_id is not unique' do
      create(:like, post: post, user: user)
      expect { create(:like, post: post, user: user) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'callbacks' do
    it { should callback(:increment_likes_count).after(:create) }
    it { should_not callback(:increment_likes_count).before(:create) }

    it { should callback(:decrement_likes_count).after(:destroy) }
    it { should_not callback(:decrement_likes_count).before(:destroy) }
  end

  context 'callback methods' do
    describe '#increment_likes_count' do
      it 'increments likes count after create' do
        expect { create(:like, post: post) }.to change { post.reload.likes_count }.from(0).to(1)
      end
    end

    describe '#decrement_likes_count' do
      it 'decrements likes count after destroy' do
        like = create(:like, post: post)
        expect { like.destroy }.to change { post.reload.likes_count }.from(1).to(0)
      end
    end
  end
end
