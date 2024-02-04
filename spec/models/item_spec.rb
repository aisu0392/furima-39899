require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { FactoryBot.create(:user) }
  it "すべて入力すれば有効であること" do

    item = Item.new(
      name: "商品名",
      description: "商品の説明",
      category_id: 2,  # 適切なカテゴリーIDを設定する
      condition_id: 2,  # 適切な状態IDを設定する
      shipping_fee_id: 2,  # 適切な送料IDを設定する
      prefecture_id: 2,  # 適切な都道府県IDを設定する
      shipping_duration_id: 2,  # 適切な発送日数IDを設定する
      price: 5000,
      user: user
    )
    item.image.attach(io: File.open('app/assets/images/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    expect(item).to be_valid
  end

  it "商品画像を1枚つけることが必須であること" do
    item = Item.new
    item.valid?
    expect(item.errors[:image]).to include("can't be blank")
  end
  

  it "商品名がない場合は無効であること" do
    item = FactoryBot.build(:item, user: user, name: nil)
    expect(item).not_to be_valid
    expect(item.errors[:name]).to include("can't be blank")
  end

  it "商品説明がない場合は無効であること" do
    item = FactoryBot.build(:item, user: user, description: nil)
    expect(item).not_to be_valid
    expect(item.errors[:description]).to include("can't be blank")
  end

  # 他の必須項目に関するテストも同様に記述

  it "カテゴリーの情報が必須であること" do
    item = FactoryBot.build(:item, user: user, category_id: nil)
    expect(item).not_to be_valid
    expect(item.errors[:category]).to include("can't be blank")
  end
  
  it "商品の状態の情報が必須であること" do
    item = FactoryBot.build(:item, user: user, condition_id: nil)
    expect(item).not_to be_valid
    expect(item.errors[:condition]).to include("can't be blank")
  end
  
  it "配送料の負担の情報が必須であること" do
    item = FactoryBot.build(:item, user: user, shipping_fee_id: nil)
    expect(item).not_to be_valid
    expect(item.errors[:shipping_fee]).to include("can't be blank")
  end
  
  it "発送までの日数の情報が必須であること" do
    item = FactoryBot.build(:item, user: user, shipping_duration_id: nil)
    expect(item).not_to be_valid
    expect(item.errors[:shipping_duration]).to include("can't be blank")
  end
  
  it "価格の情報が必須であること" do
    item = FactoryBot.build(:item, user: user, price: nil)
    expect(item).not_to be_valid
    expect(item.errors[:price]).to include("can't be blank")
  end

  it "価格が数字以外の場合は無効であること" do
    item = FactoryBot.build(:item, user: user, price: "invalid_price")
    expect(item).not_to be_valid
    expect(item.errors[:price]).to include("is not a number")
  end

  it "価格が300未満の場合は無効であること" do
    item = FactoryBot.build(:item, user: user, price: 299)
    expect(item).not_to be_valid
    expect(item.errors[:price]).to include("must be greater than or equal to 300")
  end

  it "価格が9,999,999を超える場合は無効であること" do
    item = FactoryBot.build(:item, user: user, price: 10_000_000)
    expect(item).not_to be_valid
    expect(item.errors[:price]).to include("must be less than or equal to 9999999")
  end
end
