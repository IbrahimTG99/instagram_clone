require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  let(:user) { create(:user, private: true) }
  let(:other_user) { create(:user) }

  context 'if user signed in' do
    before do
      sign_in user
    end

    describe 'Post #follow_user' do
      it 'returns js to change follow-btn and creates following_relationships' do
        post :follow_user, params:{ id: other_user.id }, format: :js
        expect(user.following.count).to eq(1)
      end

      it 'returns js to change follow-btn and creates following_relationships with status pending' do
        sign_in other_user
        post :follow_user, params:{ id: user.id }, format: :js
        expect(other_user.following.count).to eq(0)
      end

      it 'raises error if user not found' do
        expect{post :follow_user, params:{ id: 1 }}.to raise_error(ActiveRecord::RecordNotFound)
        expect(user.following.count).to eq(0)
      end
    end

    describe 'Post #unfollow_user' do
      before do
        user.follow other_user.id
      end

      it 'returns js to change unfollow-btn and deletes following_relationships' do
        expect(user.following.count).to eq(1)
        post :unfollow_user, params:{ id: other_user.id }, format: :js
        expect(user.following.count).to eq(0)
      end

      it 'raises error if user not found' do
        expect{post :unfollow_user, params:{ id: 1 }}.to raise_error(ActiveRecord::RecordNotFound)
        expect(user.following.count).to eq(1)
      end
    end

    describe 'where other_user is sending follow request to user' do
      before do
        other_user.follow user.id
      end

      describe 'Post #accept_follow' do
        it 'returns js to change accept-btn and sets following_relationships status to accepted' do
          expect(other_user.following.count).to eq(0)
          post :accept_follow, params:{ id: other_user.id }, format: :js
          expect(other_user.following.count).to eq(1)
        end

        it 'raises error if user not found' do
          expect{post :accept_follow, params:{ id: 1 }}.to raise_error(ActiveRecord::RecordNotFound)
          expect(other_user.following.count).to eq(0)
        end
      end

      describe 'Post #reject_follow' do
        it 'returns js to change reject-btn and deletes following_relationships' do
          expect(other_user.following_relationships.count).to eq(1)
          post :reject_follow, params:{ id: other_user.id }, format: :js
          expect(other_user.following_relationships.count).to eq(0)
        end

        it 'raises error if user not found' do
          expect{post :reject_follow, params:{ id: 1 }}.to raise_error(ActiveRecord::RecordNotFound)
          expect(other_user.following_relationships.count).to eq(1)
        end
      end
    end
  end

  context 'if user not signed in' do

    describe 'Post #follow_user' do
      it 'responds with status unauthorised' do
        post :follow_user, params:{ id: other_user.id }, format: :js
        expect(response).to be_unauthorized
      end
    end

    describe 'Post #unfollow_user' do
      it 'responds with status unauthorised' do
        post :unfollow_user, params:{ id: other_user.id }, format: :js
        expect(response).to be_unauthorized
      end
    end

    describe 'where other_user is sending follow request to user' do
      describe 'Post #accept_follow' do
        it 'responds with status unauthorised' do
          post :accept_follow, params:{ id: other_user.id }, format: :js
          expect(response).to be_unauthorized
        end
      end

      describe 'Post #reject_follow' do
          it 'responds with status unauthorised' do
          post :reject_follow, params:{ id: other_user.id }, format: :js
          expect(response).to be_unauthorized
        end
      end
    end
  end
end
