class AddProcessedFlagToStatsBatch < ActiveRecord::Migration[6.0]
  def change
    add_column :stats_batches, :processed, :boolean, default: false, index: true
  end
end
