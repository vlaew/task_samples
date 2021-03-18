# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    post
    user
    body { 'Smart and slightly funny comment.' }
  end
end
