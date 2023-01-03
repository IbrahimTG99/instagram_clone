require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
  end

  describe 'callbacks' do
    it { should callback(:increment_comments_count).after(:create) }
    it { should_not callback(:increment_comments_count).before(:create) }

    it { should callback(:decrement_comments_count).after(:destroy) }
    it { should_not callback(:decrement_comments_count).before(:destroy) }
  end

  describe 'callbacks methods' do
    context '#increment_comments_count' do
      it 'increments comments count after create' do
        expect { create(:comment, user: user, post: post) }.to change { post.reload.comments_count }
      end
    end

    context '#decrement_comments_count' do
      it 'decrements comments count after destroy' do
        comment = create(:comment, user: user, post: post)
        expect { comment.destroy }.to change { post.reload.comments_count }.by(-1)
      end
    end
  end
end
