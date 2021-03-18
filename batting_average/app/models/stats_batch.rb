# frozen_string_literal: true

class StatsBatch < ApplicationRecord
  has_one_attached :csv_file

  has_many :player_stats
  has_many :aggregated_player_stats

  scope :processed, -> { where(processed: true) }
end
