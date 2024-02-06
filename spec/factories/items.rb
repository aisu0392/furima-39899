FactoryBot.define do
  factory :item do
    name { "商品名" }
    description { "商品の説明" }
    category { Category.create(name: "カテゴリー名") }
    condition { Condition.create(name: "状態名") }
    shipping_fee { ShippingFee.create(name: "送料の負担名") }
    prefecture { Prefecture.create(name: "都道府県名") }
    shipping_duration { ShippingDuration.create(name: "発送までの日数名") }
    price { 5000 }
    user { FactoryBot.create(:user) }

    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end