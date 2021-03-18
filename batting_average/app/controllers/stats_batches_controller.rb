# frozen_string_literal: true

class StatsBatchesController < ApplicationController
  def new
    @stats_batch = StatsBatch.new
  end

  def create
    @stats_batch = StatsBatch.new(stats_batch_params)
    if @stats_batch.save
      ImportStatsBatchJob.perform_later(@stats_batch)
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def stats_batch_params
    params.require(:stats_batch).permit(:csv_file)
  end
end
