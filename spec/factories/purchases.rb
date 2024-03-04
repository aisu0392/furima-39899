FactoryBot.define do
  factory :purchase do
    user            { User.first || association(:user) }
    item            { Item.first || association(:item) }
    token           {"tok_abcdefghijk00000000000000000"}
  end
end
