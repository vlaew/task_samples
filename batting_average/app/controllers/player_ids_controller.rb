# frozen_string_literal: true

class PlayerIdsController < ApplicationController
  before_action :load_batch

  def index
    player_ids = @batch.player_stats
                       .select(:player_id)
                       .where('player_id ILIKE ?', "#{params[:q]}%")
                       .order(player_id: :asc)
                       .limit(20)
                       .distinct
                       .map(&:player_id)

    render json: player_ids
  end

  private

  def load_batch
    @batch = StatsBatch.processed.last
  end
end
