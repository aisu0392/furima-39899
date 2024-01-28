require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'ニックネームが空では登録できない' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'メールアドレスが空では登録できない' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'メールアドレスが重複していると登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'メールアドレスには@が必要である' do
      @user.email = 'testexample.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'パスワードが空では登録できない' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'パスワードが6文字未満では登録できない' do
      @user.password = 'passw'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'パスワードが半角数字のみの場合登録できない' do
      @user.password = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password は半角英数字混合で入力してください')
    end

    it 'パスワードが半角英字のみの場合登録できない' do
      @user.password = 'abcdef'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password は半角英数字混合で入力してください')
    end

    it 'パスワードとパスワード（確認）が一致していないと登録できない' do
      @user.password_confirmation = 'mismatch'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'お名前(全角)は、名字と名前がそれぞれ必須であること' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.first_name = 'Smith'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name は全角文字を使用してください')
    end

    it 'お名前カナ(全角)は、名字と名前がそれぞれ必須であること' do
      @user.last_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること' do
      @user.last_name_kana = 'すみす'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana は全角カタカナ文字を使用してください')
    end

    it '生年月日が必須であること' do
      @user.birthdate = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthdate can't be blank")
    end
  end
end
