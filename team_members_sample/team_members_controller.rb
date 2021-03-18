class API::V1::TeamMembersController < API::V1::BaseController
  before_action :load_team

  def index
    members  = policy_scope @team.team_members
    @members = TeamMemberCarrier.wrap(members)
  end

  private

  def load_team
    @team = Team.find(params[:team_id])
  end
end
