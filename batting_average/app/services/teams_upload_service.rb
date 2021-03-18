# frozen_string_literal: true

require 'csv'

class TeamsUploadService
  def initialize(teams_file)
    @teams_file = teams_file
  end

  def perform
    Team.transaction do
      Team.delete_all

      CSV.foreach(@teams_file.tempfile.path, headers: true) do |entry|
        Team.create!(
          team_id: entry['teamID'],
          year_id: entry['yearID'],
          name:    entry['name']
        )
      end
    end
  end
end


