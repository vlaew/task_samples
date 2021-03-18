# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  scope :ordered_chronologically, -> { order(id: :desc) }

  paginates_per 500
  max_paginates_per 1000
end
