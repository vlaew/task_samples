# frozen_string_literal: true

class AggregatedPlayerStat < ApplicationRecord
  belongs_to :stats_batch

  scope :ordered_by_batting_average, -> { order(batting_average: :desc) }
  scope :ordered_by_player_id, -> { order(player_id: :asc) }

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false, cascade: false)
  end
end
