require 'rails_helper'

RSpec.describe PurchaseForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    # PurchaseFormのインスタンスを作成
    @purchase_form = FactoryBot.build(:purchase_form, user: @user, item: @item)
  end

  context '購入ができる時' do
    it 'すべての情報が正しく入力されている場合' do
      expect(@purchase_form).to be_valid
    end
  end

  context '購入ができない時' do
    it 'userが紐付いていないと保存ができないこと' do
      @purchase_form.user = nil
      @purchase_form.valid?
      expect(@purchase_form.errors[:user]).to include("must exist")
    end
  
    it 'itemが紐付いていないと保存ができないこと' do
      @purchase_form.item = nil
      @purchase_form.valid?
      expect(@purchase_form.errors[:item]).to include("must exist")
    end

    it 'tokenが空では登録できないこと' do
      @purchase_form.token = nil
      @purchase_form.valid?
      expect(@purchase_form.errors[:token]).to include("can't be blank")
    end

    it '郵便番号がない場合' do
      @purchase_form.postal_code = nil
      @purchase_form.valid?
      expect(@purchase_form.errors[:postal_code]).to include("can't be blank")
    end

    it '郵便番号が不正な形式の場合' do
      @purchase_form.postal_code = '1234567'
      @purchase_form.valid?
      expect(@purchase_form.errors[:postal_code]).to include('is invalid. Enter it as follows (e.g. 123-4567)')
    end

    it '都道府県がない場合' do
      @purchase_form.prefecture_id = nil
      @purchase_form.valid?
      expect(@purchase_form.errors[:prefecture_id]).to include("can't be blank")
    end

    it '市区町村がない場合' do
      @purchase_form.city = nil
      @purchase_form.valid?
      expect(@purchase_form.errors[:city]).to include("can't be blank")
    end

    it '番地がない場合' do
      @purchase_form.street_address = nil
      @purchase_form.valid?
      expect(@purchase_form.errors[:street_address]).to include("can't be blank")
    end

    it '電話番号がない場合' do
      @purchase_form.phone_number = nil
      @purchase_form.valid?
      expect(@purchase_form.errors[:phone_number]).to include("can't be blank")
    end

    it '電話番号が短すぎる場合' do
      @purchase_form.phone_number = '123'
      @purchase_form.valid?
      expect(@purchase_form.errors[:phone_number]).to include('is too short')
    end

    it '電話番号が不正な形式の場合' do
      @purchase_form.phone_number = 'invalid_number'
      @purchase_form.valid?
      expect(@purchase_form.errors[:phone_number]).to include('is invalid. Input only number')
    end
  end
end
