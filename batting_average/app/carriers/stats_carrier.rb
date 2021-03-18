# frozen_string_literal: true

class StatsCarrier
  def initialize(stats_batch, params = {})
    @stats_batch = stats_batch
    @params = params
  end

  def filter
    StatsFilter.new(@params[:stats_filter], players_scope)
  end

  def player_stats
    scope = filtered_by_year(players_scope)
    scope = filtered_by_player(scope)
    scope = ordered_scope(scope)
    paginated_scope(scope)
  end

  def version
    return 'n\a' unless @stats_batch

    @stats_batch.created_at
  end

  private

  def filtered_by_year(scope)
    return scope if filter.year_id.blank?

    scope.where(year_id: filter.year_id)
  end

  def filtered_by_player(scope)
    return scope if filter.player_id.blank?

    scope.where(player_id: filter.player_id)
  end

  def ordered_scope(scope)
    scope.ordered_by_batting_average.ordered_by_player_id
  end

  def paginated_scope(scope)
    scope.page(@params[:page] || 1).per(100)
  end

  def players_scope
    return AggregatedPlayerStat.none unless @stats_batch

    @stats_batch.aggregated_player_stats
  end
end
