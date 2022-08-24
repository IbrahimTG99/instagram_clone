require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  context 'if user signed in' do
    before do
      sign_in user
    end

    describe 'GET #index' do
      it 'returns http success along with posts, stories, follower_suggestions and pending_follows variables' do
        get :index
        expect(assigns(:posts)).to eq(Post.of_followed_users(user.following + [user]))
        expect(assigns(:stories)).to eq(Story.of_followed_users(user.following + [user]))
        expect(assigns(:follower_suggestions)).to eq(User.where.not(id: user.following_relationships.pluck(:following_id)) - [user])
        expect(assigns(:pending_follows)).to eq(user.following_relationships.where(status: 'pending'))
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET #profile' do
      it 'returns http success along with posts and user variables' do
        get :profile, params:{ username: user.username }
        expect(assigns(:user)).to eq(user)
        expect(assigns(:posts)).to eq(user.posts)
        expect(response).to have_http_status(:success)
      end

      it 'raises error if user not found' do
        expect{get :profile, params:{ username: 'name' }}.to raise_error(NoMethodError)
      end
    end
    describe 'GET #search' do
      it 'returns http success along with searched user in json format' do
        get :search, params:{ q: user.username }
        expect(response).to have_http_status(:success)
        parsed_body = JSON.parse(response.body)
        expect(parsed_body.first['username']).to eq(user.username)
      end

      it 'returns empty body when user not found' do
        expect{get :search, params:{ q: 'name' }}
        expect(response).to have_http_status(:success)
        expect(response.body).to be_empty
      end
    end

    describe 'Delete #destroy' do
      it 'redirects to root after deleting user' do
        expect {delete :destroy, params:{ id: user.id, username: user.username } }.to change(User, :count).from(1).to(0)
        expect(response).to redirect_to(root_path)
      end

      it 'raises error when no user found' do
        expect{delete :destroy, params:{ id: 1, username: 'name' } }.to raise_error(NoMethodError)
      end
    end
  end

  context 'if user not signed in' do
    describe 'GET #index' do
      it 'returns http redirect status code and redirects to sign_in page' do
        get :index
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to redirect_to(user_session_path)
      end
    end

    describe 'GET #profile' do
      it 'returns http redirect status code and redirects to sign_in page' do
        get :profile, params:{ username: user.username }
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to redirect_to(user_session_path)
      end
    end

    describe 'GET #search' do
      it 'returns http redirect status code and redirects to sign_in page' do
        get :search, params:{ q: user.username }
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to redirect_to(user_session_path)
      end
    end

    describe 'Delete #destroy' do
      it 'redirect status code and redirects to sign_in page' do
        delete :destroy, params:{ id: user.id }
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to redirect_to(user_session_path)
      end
    end
  end
end
