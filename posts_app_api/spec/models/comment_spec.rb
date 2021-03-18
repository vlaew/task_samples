# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#post' do
    it 'validates post presence' do
      comment = FactoryBot.build(:comment, post: nil)

      expect(comment).not_to be_valid
    end
  end

  describe '#user' do
    it 'validates user presence' do
      comment = FactoryBot.build(:comment, user: nil)

      expect(comment).not_to be_valid
    end
  end
end
