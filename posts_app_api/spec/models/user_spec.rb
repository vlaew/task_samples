# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#token' do
    it 'generates token for new user' do
      user = FactoryBot.create(:user)

      expect(user.token).not_to be_blank
    end
  end

  describe '#name' do
    it 'validates name presence' do
      user = FactoryBot.build(:user, name: nil)

      expect(user).not_to be_valid
    end
  end

  describe '#email' do
    it 'validates email presence' do
      user = FactoryBot.build(:user, email: nil)

      expect(user).not_to be_valid
    end

    it 'validates email uniqueness' do
      FactoryBot.create(:user, email: 'john@example.com')
      user = FactoryBot.build(:user, email: 'john@example.com')

      expect(user).not_to be_valid
    end
  end
end
