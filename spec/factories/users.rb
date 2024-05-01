FactoryBot.define do
  factory :user do
    role { :user }
    sequence(:first_name) { |n| "User #{n}" }
    sequence(:last_name) { |n| "User #{n}" }
    sequence(:email) { |n| "email#{n}@example.com" }
    password { "example123" }

    trait :admin do
      role { :admin }
    end

    trait :user do
      role { :user }
    end
  end
end
