FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { 'testtesttest@example.com' }
    password              { 'password' }
    password_confirmation { 'password' }
    last_name             { '山田' }
    first_name            { '太郎' }
    last_name_kana        { 'ヤマダ' }
    first_name_kana       { 'タロウ' }
    birthdate             { '1990-01-01' }
  end
end