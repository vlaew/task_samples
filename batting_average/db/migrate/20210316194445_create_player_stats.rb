class CreatePlayerStats < ActiveRecord::Migration[6.0]
  def change
    create_table :player_stats do |t|
      t.belongs_to :stats_batch, null: false, index: true
      t.string :player_id, index: true
      t.string :year_id, index: true
      t.string :team_id, index: true
      t.string :stint
      t.decimal :batting_average, precision: 15, scale: 3

      t.timestamps null: false
    end
  end
end
