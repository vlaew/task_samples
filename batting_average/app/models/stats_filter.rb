# frozen_string_literal: true

class StatsFilter
  include ActiveModel::Model

  def initialize(filter_params, scope)
    @filter_params = filter_params
    @scope = scope
  end

  def year_id
    return unless @filter_params

    @filter_params[:year_id]
  end

  def player_id
    return unless @filter_params

    @filter_params[:player_id]
  end

  def years_range
    return [] if @scope.empty?

    Range.new(@scope.minimum(:year_id), @scope.maximum(:year_id))
  end
end
