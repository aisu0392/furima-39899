require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '新規登録できるとき' do
      it '正常なデータで登録できること' do
        @user.valid?
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do

      it 'ニックネームが空では登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'メールアドレスが空では登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end

      it 'メールアドレスが重複していると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'メールアドレスには@が必要である' do
        @user.email = 'testexample.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'パスワードが空では登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'パスワードが6文字未満では登録できない' do
        @user.password = 'passw'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'パスワードが半角数字のみの場合登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
      end

      it 'パスワードが半角英字のみの場合登録できない' do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
      end

      it 'パスワードとパスワード（確認）が一致していないと登録できない' do
        @user.password_confirmation = 'mismatch'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'パスワード１'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
      end

      it 'お名前(全角)は、名字と名前がそれぞれ必須であること' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("名を入力してください")
      end

      it '姓（全角）が空だと登録できない' do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("姓を入力してください")
      end
    
      it '姓（全角）に半角文字が含まれていると登録できない' do
        @user.last_name = 'Smith'
        @user.valid?
        expect(@user.errors.full_messages).to include("姓は全角文字を使用してください")
      end

      it '名(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.first_name = 'Smith'
        @user.valid?
        expect(@user.errors.full_messages).to include('名は全角文字を使用してください')
      end

      it '姓カナ(全角)は、名字と名前がそれぞれ必須であること' do
        @user.last_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("セイを入力してください")
      end

      it '姓カナ(全角)は、全角（カタカナ）での入力が必須であること' do
        @user.last_name_kana = 'すみす'
        @user.valid?
        expect(@user.errors.full_messages).to include('セイは全角カタカナ文字を使用してください')
      end

      it '名（カナ）が空だと登録できない' do
        @user.first_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("メイを入力してください")
      end
    
      it '名（カナ）にカタカナ以外の文字が含まれていると登録できない' do
        @user.first_name_kana = 'かな123'
        @user.valid?
        expect(@user.errors.full_messages).to include("メイは全角カタカナ文字を使用してください")
      end

      it '生年月日が必須であること' do
        @user.birthdate = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
