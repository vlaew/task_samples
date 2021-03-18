# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#post' do
    it 'validates post presence' do
      like = FactoryBot.build(:like, post: nil)

      expect(like).not_to be_valid
    end
  end

  describe '#user' do
    it 'validates user presence' do
      like = FactoryBot.build(:like, user: nil)

      expect(like).not_to be_valid
    end

    it 'validates that user can have only one like per post' do
      post = FactoryBot.create(:post)
      user = FactoryBot.create(:user)
      FactoryBot.create(:like, post: post, user: user)

      like = FactoryBot.build(:like, post: post, user: user)

      expect(like).not_to be_valid
    end
  end
end
