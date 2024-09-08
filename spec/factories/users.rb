# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    send_due_date_reminder { false }
    due_date_reminder_interval { 1 }
    due_date_reminder_time { '10:00' }
    time_zone { 'Cairo' }

    trait :with_invalid_name do
      name { '' }
    end
    trait :with_invalid_email do
      email { 'bademail.com' }
    end
  end
end
