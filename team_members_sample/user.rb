class User < ApplicationRecord
  has_many :team_memberships, class_name: 'TeamMember', dependent: :destroy
  has_many :teams, through: :team_memberships, class_name: 'Team'
end
