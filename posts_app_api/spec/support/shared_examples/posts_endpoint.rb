# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'posts endpoint' do
  describe '#index' do
    describe 'returned posts' do
      before do
        FactoryBot.create_list(:post, 5)
      end

      it 'returns success' do
        get @endpoint_path

        expect(response).to have_http_status(:success)
      end

      it 'returns all existing posts' do
        get @endpoint_path

        expect(parsed_response_body[:data].size).to eq(5)
      end

      it 'returns correct json posts schema' do
        get @endpoint_path

        expect(response).to match_response_schema('posts')
      end
    end

    describe 'likes count for posts' do
      before do
        users = FactoryBot.create_list(:user, 5)
        @posts_5_likes = FactoryBot.create_list(:post, 2, :with_likes, liked_by: users)
        @posts_0_likes = FactoryBot.create_list(:post, 3)
      end

      it 'returns likes count for posts with likes' do
        get @endpoint_path

        posts_with_likes = parsed_response_body[:data].select { |entry| entry['attributes']['likes_count'] > 0 }
        expect(posts_with_likes.map { |post| post['id'] }).to match_array(@posts_5_likes.map(&:id).map(&:to_s))
        expect(posts_with_likes.map { |post| post['attributes']['likes_count'] }).to eq([5, 5])
      end

      it 'returns zero likes count for posts without likes' do
        get @endpoint_path

        posts_with_likes = parsed_response_body[:data].select { |post| post['attributes']['likes_count'] == 0 }
        expect(posts_with_likes.map { |post| post['id'] }).to match_array(@posts_0_likes.map(&:id).map(&:to_s))
        expect(posts_with_likes.map { |post| post['attributes']['likes_count'] }).to eq([0, 0, 0])
      end
    end

    describe 'pagination' do
      before do
        FactoryBot.create_list(:post, 550)
        @request_path = @endpoint_path
        @total_records = 550
        @per_page = 500
      end

      it_behaves_like 'paginated collection response'
    end

    describe 'posts order' do
      before do
        FactoryBot.create(:post, created_at: '2020-03-27T18:28:42.956Z')
        FactoryBot.create(:post, created_at: '2020-03-25T18:28:42.956Z')
        FactoryBot.create(:post, created_at: '2020-03-26T18:28:42.956Z')
      end

      it 'returns posts in order of creation' do
        get @endpoint_path

        posts_dates = parsed_response_body[:data].map { |comment| comment['attributes']['published_at'] }
        expected_dates_order = [
          '2020-03-27T18:28:42.956Z',
          '2020-03-26T18:28:42.956Z',
          '2020-03-25T18:28:42.956Z'
        ]
        expect(posts_dates).to eq(expected_dates_order)
      end
    end
  end

  describe '#toggle_like' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:post_entry) { FactoryBot.create(:post) }

      context 'when post was not liked by user' do
        it 'returns success' do
          post "#{@endpoint_path}/#{post_entry.id}/toggle_like", headers: auth_headers(user)

          expect(response).to have_http_status(:success)
        end

        it 'creates like for the post' do
          expect do
            post "#{@endpoint_path}/#{post_entry.id}/toggle_like", headers: auth_headers(user)
          end.to change { post_entry.likes.where(user: user).count }.by(1)
        end

        it 'increases likes count for the post' do
          expect do
            post "#{@endpoint_path}/#{post_entry.id}/toggle_like", headers: auth_headers(user)
          end.to change { post_entry.reload.likes_count.to_i }.by(1)
        end
      end

      context 'when post was already liked by user' do
        before do
          FactoryBot.create(:like, user: user, post: post_entry)
        end

        it 'returns success' do
          post "#{@endpoint_path}/#{post_entry.id}/toggle_like", headers: auth_headers(user)

          expect(response).to have_http_status(:success)
        end

        it 'destroys like for the post' do
          expect do
            post "#{@endpoint_path}/#{post_entry.id}/toggle_like", headers: auth_headers(user)
          end.to change { post_entry.likes.where(user: user).count }.by(-1)
        end

        it 'decreases likes count for the post' do
          expect do
            post "#{@endpoint_path}/#{post_entry.id}/toggle_like", headers: auth_headers(user)
          end.to change { post_entry.reload.likes_count.to_i }.by(-1)
        end
      end
    end

    context 'when user is not signed in' do
      let(:post_entry) { FactoryBot.create(:post) }

      it 'returns unauthenticated' do
        post "#{@endpoint_path}/#{post_entry.id}/toggle_like"

        expect(response).to have_http_status(:unauthorized)
      end

      it 'does not create like' do
        expect do
          post "#{@endpoint_path}/#{post_entry.id}/toggle_like"
        end.not_to(change { post_entry.likes.count })
      end
    end
  end
end
