require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user: @user)
  end

  context '新規登録ができる時' do
    it 'すべての情報が正しく入力されている場合' do
      expect(@item).to be_valid
    end
  end

  context '新規登録ができない時' do
    it '商品画像がない場合' do
      @item.image = nil
      @item.valid?
      expect(@item.errors[:image]).to include("can't be blank")
    end

    it '商品名がない場合' do
      @item.name = ''
      expect(@item).not_to be_valid
      expect(@item.errors[:name]).to include("can't be blank")
    end

    it '商品説明がない場合' do
      @item.description = ''
      expect(@item).not_to be_valid
      expect(@item.errors[:description]).to include("can't be blank")
    end

    it 'カテゴリーの情報がない場合' do
      @item.category_id = nil
      expect(@item).not_to be_valid
      expect(@item.errors[:category]).to include("can't be blank")
    end

    it '商品の状態の情報がない場合' do
      @item.condition_id = nil
      expect(@item).not_to be_valid
      expect(@item.errors[:condition]).to include("can't be blank")
    end

    it '配送料の負担の情報がない場合' do
      @item.shipping_fee_id = nil
      expect(@item).not_to be_valid
      expect(@item.errors[:shipping_fee]).to include("can't be blank")
    end

    it '発送までの日数の情報がない場合' do
      @item.shipping_duration_id = nil
      expect(@item).not_to be_valid
      expect(@item.errors[:shipping_duration]).to include("can't be blank")
    end

    it '価格の情報がない場合' do
      @item.price = nil
      expect(@item).not_to be_valid
      expect(@item.errors[:price]).to include("can't be blank")
    end

    it '価格が数字以外の場合' do
      @item.price = "invalid_price"
      expect(@item).not_to be_valid
      expect(@item.errors[:price]).to include("is not a number")
    end

    it '価格が300未満の場合' do
      @item.price = 299
      expect(@item).not_to be_valid
      expect(@item.errors[:price]).to include("must be greater than or equal to 300")
    end

    it '価格が9,999,999を超える場合' do
      @item.price = 10_000_000
      expect(@item).not_to be_valid
      expect(@item.errors[:price]).to include("must be less than or equal to 9999999")
    end
  end
end
