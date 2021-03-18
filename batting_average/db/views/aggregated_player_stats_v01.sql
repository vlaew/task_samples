SELECT
  stats_batch_id,
  player_id,
  player_stats.year_id,
  array_agg(player_teams.name) as teams,
  avg(batting_average) as batting_average
FROM player_stats
INNER JOIN (
    SELECT DISTINCT team_id, name, year_id
    FROM teams
) as player_teams
ON player_teams.team_id = player_stats.team_id AND player_teams.year_id = player_stats.year_id
GROUP BY stats_batch_id, player_id, player_stats.year_id
