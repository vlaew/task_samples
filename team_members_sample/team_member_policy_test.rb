class TeamMemberPolicyTest < ActiveSupport::TestCase
  def setup
    user_owner = FactoryBot.create(:user)

    @team = FactoryBot.create(:team, owner: user_owner)
    @team_owner = FactoryBot.create(:team_member, team: @team, user: user_owner)
    @team_member = FactoryBot.create(:team_member, team: @team)
    @other_team_member = FactoryBot.create(:team_member)
  end

  def test_create_permission
    new_team_member = FactoryGirl.build(:team_member, team: @team)

    assert TeamMemberPolicy.new(@team_owner, new_team_member).create?
    assert TeamMemberPolicy.new(@team_member, new_team_member).create?
    refute TeamMemberPolicy.new(@other_team_member, new_team_member).create?
  end

  def test_update_permission
    assert TeamMemberPolicy.new(@team_owner, @team_member).update?
    assert TeamMemberPolicy.new(@team_member, @team_member).update?
    refute TeamMemberPolicy.new(@other_team_member, @team_member).update?
  end

  def test_destroy_permission_for_regular_member
    assert TeamMemberPolicy.new(@team_owner, @team_member).destroy?
    assert TeamMemberPolicy.new(@team_member, @team_member).destroy?
    refute TeamMemberPolicy.new(@other_team_member, @team_member).destroy?
  end

  def test_destroy_permission_for_team_owner
    refute TeamMemberPolicy.new(@team_owner, @team_owner).destroy?
    refute TeamMemberPolicy.new(@team_member, @team_owner).destroy?
    refute TeamMemberPolicy.new(@other_team_member, @team_owner).destroy?
  end
end
