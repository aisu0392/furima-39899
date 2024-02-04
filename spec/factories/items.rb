FactoryBot.define do
  factory :item do
    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end
