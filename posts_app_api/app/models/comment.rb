# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :post, optional: false

  scope :ordered_chronologically, -> { order(created_at: :asc) }

  paginates_per 20
  max_paginates_per 100
end
