class TeamMember < ApplicationRecord
  belongs_to :team
  belongs_to :user

  scope :for_user, ->(user) { where(user: user) }
end
