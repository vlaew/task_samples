class TeamMemberCarrier
  attr_reader :team_member

  delegate :id,
           :notification_level,
           to: :team_member
  delegate :id,
           :email,
           to: :user, prefix: true

  def self.wrap(team_members)
    team_members.includes(:user).map(&method(:new))
  end

  def initialize(team_member)
    @team_member = team_member
  end

  def role
    I18n.t(user.role || User::DEFAULT_ROLE, scope: 'team_member.role', raise: true)
  end

  def owner?
    team_member.team.owner == user
  end

  def name
    user.name.presence || I18n.t('team_member.missing_name')
  end

  def notification_level_label
    I18n.t(team_member.notification_level, scope: 'team_member.notification_level', raise: true)
  end

  def photo_url
    user.photo_url(:profile)
  end

  private

  def user
    team_member.user
  end
end
