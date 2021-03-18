# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    sequence(:body) { |n| "Sample body post ##{n}" }

    trait :with_likes do
      transient do
        liked_by { [] }
      end

      after(:create) do |post, evaluator|
        evaluator.liked_by.each do |user|
          FactoryBot.create(:like, post: post, user: user)
        end
      end
    end
  end
end
