# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Comments', type: :request do
  include RequestHelpers
  include AuthHelper

  describe 'api/v1/comments#index' do
    describe 'response structure' do
      before do
        FactoryBot.create_list(:comment, 26)
        FactoryBot.create_list(:comment, 13, post: post)
      end

      let(:post) { FactoryBot.create(:post) }

      it 'returns success' do
        get "/api/v1/posts/#{post.id}/comments"

        expect(response).to have_http_status(:success)
      end

      it 'returns comments for a post' do
        get "/api/v1/posts/#{post.id}/comments"

        comments = parsed_response_body[:data]
        expect(comments.size).to eq(13)
        expect(comments.map { |comment| comment['id'] }).to match_array(post.comments.map(&:id))
      end

      it 'returns correct json schema' do
        get "/api/v1/posts/#{post.id}/comments"

        expect(response).to match_response_schema('comments')
      end
    end

    describe 'comment created_by' do
      before do
        @jane_comment = FactoryBot.create(:comment, user: jane)
      end

      let(:jane) { FactoryBot.create(:user, name: 'Jane Smith') }

      it 'returns comment creator info' do
        get "/api/v1/posts/#{@jane_comment.post.id}/comments"

        comment = parsed_response_body[:data].detect { |entry| entry['id'] == @jane_comment.id }
        expect(comment['attributes']['created_by']['id']).to eq(jane.id)
        expect(comment['attributes']['created_by']['name']).to eq('Jane Smith')
      end
    end

    describe 'comments order' do
      before do
        FactoryBot.create(:comment, post: post, created_at: '2020-03-27T18:28:42.956Z')
        FactoryBot.create(:comment, post: post, created_at: '2020-03-25T18:28:42.956Z')
        FactoryBot.create(:comment, post: post, created_at: '2020-03-26T18:28:42.956Z')
      end

      let(:post) { FactoryBot.create(:post) }

      it 'returns comments in order of creation' do
        get "/api/v1/posts/#{post.id}/comments"

        comment_dates = parsed_response_body[:data].map { |comment| comment['attributes']['created_at'] }
        expected_dates_order = [
          '2020-03-25T18:28:42.956Z',
          '2020-03-26T18:28:42.956Z',
          '2020-03-27T18:28:42.956Z'
        ]
        expect(comment_dates).to eq(expected_dates_order)
      end
    end

    describe 'pagination' do
      before do
        post = FactoryBot.create(:post)
        FactoryBot.create_list(:comment, 138, post: post)
        @request_path = "/api/v1/posts/#{post.id}/comments"
        @total_records = 138
        @per_page = 20
      end

      it_behaves_like 'paginated collection response'
    end
  end
end
