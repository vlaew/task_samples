# frozen_string_literal: true

require 'csv'

class ImportStatsBatchJob < ApplicationJob
  def perform(stats_batch)
    players_batch = []
    stats_batch.csv_file.open do |file|
      CSV.foreach(file.path, headers: true).with_index do |entry, index|
        players_batch << stats_batch.player_stats.new(
          player_id:       entry['playerID'],
          year_id:         entry['yearID'],
          team_id:         entry['teamID'],
          stint:           entry['stint'],
          batting_average: calculate_batting_average(entry['H'], entry['AB'])
        )

        if index % 10000 == 0
          PlayerStat.import(players_batch)
          players_batch = []
        end
      end
    end

    PlayerStat.import(players_batch) unless players_batch.empty?

    stats_batch.update!(processed: true)

    AggregatedPlayerStat.refresh
  end

  private

  def calculate_batting_average(hits, at_bats)
    return 0 unless at_bats.to_i.positive?

    (hits.to_f / at_bats.to_f).round(3)
  end
end
