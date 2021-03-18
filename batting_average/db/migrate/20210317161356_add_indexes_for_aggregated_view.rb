class AddIndexesForAggregatedView < ActiveRecord::Migration[6.0]
  def change
    add_index :aggregated_player_stats, :stats_batch_id
    add_index :aggregated_player_stats, :player_id
    add_index :aggregated_player_stats, :year_id
    add_index :aggregated_player_stats, :batting_average
  end
end
