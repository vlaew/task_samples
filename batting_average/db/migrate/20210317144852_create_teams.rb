class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :team_id, index: true
      t.string :year_id, index: true
      t.string :name

      t.timestamps null: false
    end
  end
end
