json.members(@members) do |member|
  json.id                       member.id
  json.name                     member.name
  json.role                     member.role
  json.notification_level       member.notification_level
  json.notification_level_label member.notification_level_label
  json.photo_url                member.photo_url
  json.user_id                  member.user_id
  json.user_email               member.user_email
  json.is_owner                 member.owner?
  json.is_removable             policy(member.team_member).destroy?
  json.is_editable              policy(member.team_member).update?
end
