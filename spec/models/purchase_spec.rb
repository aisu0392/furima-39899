require 'rails_helper'

RSpec.describe Purchase, type: :model do
  before do
    @purchase = FactoryBot.build(:purchase)
  end

  context '内容に問題ない場合' do
    it "全ての情報が正しく入力されていれば保存ができること" do
      expect(@purchase).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it "user_idが空では保存ができないこと" do
      @purchase.user_id = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("ユーザーを入力してくださ")
    end

    it "item_idが空では保存ができないこと" do
      @purchase.item_id = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("商品を入力してください")
    end

    it "priceが空では保存ができないこと" do
      @purchase.price = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("価格を入力してくださ")
    end

    it "tokenが空では登録できないこと" do
      @purchase.token = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("クレジットカード情報を入力してくださ")
    end
  end
end

