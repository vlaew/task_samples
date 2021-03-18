# frozen_string_literal: true

class TeamUploadsController < ApplicationController
  def new
  end

  def create
    TeamsUploadService.new(team_upload_params[:csv_file]).perform

    redirect_to root_path
  end

  private

  def team_upload_params
    params.require(:team_upload).permit(:csv_file)
  end
end
