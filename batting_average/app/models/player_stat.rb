# frozen_string_literal: true

class PlayerStat < ApplicationRecord
  belongs_to :stats_batch

  scope :ordered_by_batting_average, -> { order(batting_average: :desc) }
  scope :ordered_by_player_id, -> { order(player_id: :asc) }
end
