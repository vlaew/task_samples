# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_17_161356) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "player_stats", force: :cascade do |t|
    t.bigint "stats_batch_id", null: false
    t.string "player_id"
    t.string "year_id"
    t.string "team_id"
    t.string "stint"
    t.decimal "batting_average", precision: 15, scale: 3
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_player_stats_on_player_id"
    t.index ["stats_batch_id"], name: "index_player_stats_on_stats_batch_id"
    t.index ["team_id"], name: "index_player_stats_on_team_id"
    t.index ["year_id"], name: "index_player_stats_on_year_id"
  end

  create_table "stats_batches", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "processed", default: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "team_id"
    t.string "year_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_teams_on_team_id"
    t.index ["year_id"], name: "index_teams_on_year_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"

  create_view "aggregated_player_stats", materialized: true, sql_definition: <<-SQL
      SELECT player_stats.stats_batch_id,
      player_stats.player_id,
      player_stats.year_id,
      array_agg(player_teams.name) AS teams,
      avg(player_stats.batting_average) AS batting_average
     FROM (player_stats
       JOIN ( SELECT DISTINCT teams.team_id,
              teams.name,
              teams.year_id
             FROM teams) player_teams ON ((((player_teams.team_id)::text = (player_stats.team_id)::text) AND ((player_teams.year_id)::text = (player_stats.year_id)::text))))
    GROUP BY player_stats.stats_batch_id, player_stats.player_id, player_stats.year_id;
  SQL
  add_index "aggregated_player_stats", ["batting_average"], name: "index_aggregated_player_stats_on_batting_average"
  add_index "aggregated_player_stats", ["player_id"], name: "index_aggregated_player_stats_on_player_id"
  add_index "aggregated_player_stats", ["stats_batch_id"], name: "index_aggregated_player_stats_on_stats_batch_id"
  add_index "aggregated_player_stats", ["year_id"], name: "index_aggregated_player_stats_on_year_id"

end
