# frozen_string_literal: true

class FreshStatsController < ApplicationController
  before_action :load_batch

  def index
    @stats_carrier = StatsCarrier.new(@batch, params)
  end

  private

  def load_batch
    @batch = StatsBatch.processed.last
  end
end
