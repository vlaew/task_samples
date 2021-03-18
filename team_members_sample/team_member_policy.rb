class TeamMemberPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(team_id: user.team_memberships.pluck(:team_id))
    end
  end

  def create?
    user_belongs_to_team?
  end

  def update?
    create?
  end

  def destroy?
    update? && !member_is_team_owner?
  end

  private

  def member_is_team_owner?
    record.team.owner == record.user
  end

  def user_belongs_to_team?
    record.team.team_members.for_user(user).exists?
  end
end
