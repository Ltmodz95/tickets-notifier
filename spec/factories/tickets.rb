# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    due_date { Time.current + 2.days }
    progress { 0 }
    status { 'to_do' }
    association :assignee, factory: :user

    trait :with_empty_title do
      title { '' }
    end

    trait :with_empty_description do
      description { '' }
    end
  end
end
