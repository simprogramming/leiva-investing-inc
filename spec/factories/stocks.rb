FactoryBot.define do
  factory :stock do
    name { "MyString" }
    symbol { "XEI" }
    price { 1.5 }
    status { "watching" }
    dividend { false }
    position { 1 }
    api_symbol { "XEI:TSX" }
  end
end
