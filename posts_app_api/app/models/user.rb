# frozen_string_literal: true

class User < ApplicationRecord
  has_many :likes, dependent: :destroy

  before_validation :ensure_token

  validates :email, :name, :token, presence: true
  validates :token, :email, uniqueness: true

  private

  def ensure_token
    return true if token

    self.token = loop do
      value = SecureRandom.urlsafe_base64(12)
      break value unless self.class.exists?(token: value)
    end
  end
end
