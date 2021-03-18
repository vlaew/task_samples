class TeamMemberCarrierTest < ActiveSupport::TestCase
  def test_role
    user_client = FactoryBot.create(:user, role: :client)
    user_owner = FactoryBot.create(:user, role: :owner)
    user_without_role = FactoryBot.create(:user, role: nil)

    client = TeamMemberCarrier.new(FactoryBot.create(:team_member, user: user_client))
    owner = TeamMemberCarrier.new(FactoryBot.create(:team_member, user: user_owner))
    member_without_role = TeamMemberCarrier.new(FactoryBot.create(:team_member, user: user_without_role))

    assert_equal 'Client', client.role
    assert_equal 'Company owner', owner.role
    assert_equal 'N/A', member_without_role.role
  end

  def test_owner
    user = FactoryBot.create(:user)
    team = FactoryBot.create(:team, owner: user)

    team_owner = FactoryBot.create(
      :team_member,
      user: user,
      team: team
    )
    team_member = FactoryBot.create(:team_member, team: team)

    assert TeamMemberCarrier.new(team_owner).owner?
    refute TeamMemberCarrier.new(team_member).owner?
  end

  def test_name
    user = FactoryBot.create(:user, first_name: 'John', last_name: 'Doe')
    noname_user = FactoryBot.create(:user, first_name: nil, last_name: nil)

    member_carrier = TeamMemberCarrier.new(FactoryBot.create(:team_member, user: user))
    noname_member_carrier = TeamMemberCarrier.new(FactoryBot.create(:team_member, user: noname_user))

    assert_equal 'John Doe', member_carrier.name
    assert_equal 'N/A', noname_member_carrier.name
  end

  def test_notification_level
    member_all = TeamMemberCarrier.new(FactoryBot.create(:team_member, notification_level: :all))
    member_muted = TeamMemberCarrier.new(FactoryBot.create(:team_member, notification_level: :muted))
    member_mentions = TeamMemberCarrier.new(FactoryBot.create(:team_member, notification_level: :mentions))

    assert_equal 'all', member_all.notification_level
    assert_equal 'Receive All Notifications', member_all.notification_level_label
    assert_equal 'muted', member_muted.notification_level
    assert_equal 'Muted', member_muted.notification_level_label
    assert_equal 'mentions', member_mentions.notification_level
    assert_equal 'Receive Mentions', member_mentions.notification_level_label
  end

  def test_id
    member = FactoryBot.create(:team_member)

    assert_equal member.id, TeamMemberCarrier.new(member).id
  end

  def test_user_id
    user = FactoryBot.create(:user)
    member = FactoryBot.create(:team_member, user: user)

    assert_equal user.id, TeamMemberCarrier.new(member).user_id
  end

  def test_user_email
    user = FactoryBot.create(:user, email: 'john@example.com')
    member = FactoryBot.create(:team_member, user: user)

    assert_equal 'john@example.com', TeamMemberCarrier.new(member).user_email
  end

  def test_wrap
    members = FactoryBot.create_list(:team_member, 3)
    carriers = TeamMemberCarrier.wrap(members)

    assert_equal 3, carriers.size
    assert carriers.all? { |carrier| carrier.is_a?(TeamMemberCarrier) }
  end
end
