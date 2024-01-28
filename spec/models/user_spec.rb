require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.build(:user)
  end

    describe 'ユーザー新規登録' do
    it 'ニックネームが空では登録できない' do
      user.nickname = ''
      user.valid?
      expect(user.errors.full_messages).to include('Nicknameは入力必須項目です')
    end

    it 'メールアドレスが空では登録できない' do
      user.email = ''
      user.valid?
      expect(user.errors.full_messages).to include('Emailは入力必須項目です')
    end

     it 'メールアドレスが重複していると登録できない' do
       create(:user, email: 'test@example.com')
       user = build(:user, email: 'test@example.com')
       #user.email = 'test@example.com'
       user.valid?
       expect(user.errors.full_messages).to include('Emailはすでに存在します')
     end

    it 'メールアドレスには@が必要である' do
      user = build(:user, email: 'testexample.com')
      #user.email = 'testexample.com'
      user.valid?
      expect(user.errors.full_messages).to include('Emailは有効でありません')
    end

    it 'パスワードが空では登録できない' do
      user.password = user.password_confirmation = ''
      user.valid?
      expect(user.errors.full_messages).to include('Passwordは入力必須項目です')
    end

    it 'パスワードが6文字未満では登録できない' do
      user.password = user.password_confirmation = '12345'
      user.valid?
      expect(user.errors.full_messages).to include('Passwordは6文字以上で入力してください')
    end

    it 'パスワードが半角英数字混合でないと登録できない' do
      user = build(:user, password: 'password') 
      #user.password = user.password_confirmation = 'password'
      user.valid?
      expect(user.errors.full_messages).to include('Passwordは半角英数字混合で入力してください')
    end

    it 'パスワードとパスワード（確認）が一致していないと登録できない' do
      user = build(:user, password: 'password', password_confirmation: 'different_password') 
      #user.password_confirmation = 'different_password'
      user.valid?
      expect(user.errors.full_messages).to include('Password confirmationとPasswordの入力が一致しません')
    end

    # 本人情報確認
    it 'お名前(全角)は、名字と名前がそれぞれ必須であること' do
      user.first_name = ''
      user.valid?
      expect(user.errors.full_messages).to include('First nameは入力必須項目です')
    end

    it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      user.first_name = '山田123'
      user.valid?
      expect(user.errors.full_messages).to include('First nameは全角文字を使用してください')
    end

    it 'お名前カナ(全角)は、名字と名前がそれぞれ必須であること' do
      user.last_name_kana = ''
      user.valid?
      expect(user.errors.full_messages).to include('Last name kanaは入力必須項目です')
    end

    it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること' do
      user.last_name_kana = 'ﾔﾏﾀﾞ'
      user.valid?
      expect(user.errors.full_messages).to include('Last name kanaは全角カタカナ文字を使用してください')
    end

    it '生年月日が必須であること' do
      user.birthdate = nil
      user.valid?
      expect(user.errors.full_messages).to include('Birthdateは入力必須項目です')
    end
  end
end