FactoryBot.define do
  factory :wallet do
    cash { 1.5 }
    user
    name { "MyString" }
  end
end
