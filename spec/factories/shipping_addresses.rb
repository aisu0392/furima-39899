FactoryBot.define do
  factory :shipping_address do
    purchase { nil }
    postal_code { "MyString" }
    prefecture_id { 1 }
    city { "MyString" }
    street_address { "MyString" }
    building_name { "MyString" }
    phone_number { "MyString" }
  end
end
