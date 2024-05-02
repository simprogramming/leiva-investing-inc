FactoryBot.define do
  factory :position do
    wallet
    stock
    size { 1.5 }
    entry { 1.5 }
  end
end
