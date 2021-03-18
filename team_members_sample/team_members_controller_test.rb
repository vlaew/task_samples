class API::V1::TeamMembersControllerTest < ActionController::TestCase
  def setup
    user_owner = FactoryBot.create(:user)

    @team = FactoryBot.create(:team, owner: user_owner)
    @team_owner = FactoryBot.create(:team_member, team: @team, user: user_owner)
    @team_member = FactoryBot.create(:team_member, team: @team)
    @other_team_member = FactoryBot.create(:team_member)

    sing_in @team_member.user
  end

  def test_index_returns_members_for_team
    get :index, format: :json, team_id: @team.id

    index = JSON.parse(response.body)
    members_ids = index['members'].map { |member| member['id'] }

    assert_equal 2, index['members'].count
    assert members_ids.include(@team_owner.id)
    assert members_ids.include(@team_member.id)
    refute members_ids.include(@other_team_member.id)
  end
end
