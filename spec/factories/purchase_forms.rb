FactoryBot.define do
  factory :purchase_form do
    postal_code        { '123-4567' }
    prefecture_id      { 2 }
    city               { 'Example City' }
    street_address     { 'Example Street' }
    phone_number       { '1234567890' }
    token              {"tok_abcdefghijk00000000000000000"}
  end
end
