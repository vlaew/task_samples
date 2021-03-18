class CreateAggregatedPlayerStats < ActiveRecord::Migration[6.0]
  def change
    create_view :aggregated_player_stats, materialized: true
  end
end
