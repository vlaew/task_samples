class CreateStatsBatch < ActiveRecord::Migration[6.0]
  def change
    create_table :stats_batches do |t|

      t.timestamps null: false
    end
  end
end
