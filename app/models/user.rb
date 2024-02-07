class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :items

  validates :nickname, presence: true
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: "は半角英数字混合で入力してください" }
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々ヴァヶー]+\z/, message: "は全角文字を使用してください" }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々ヴァヶー]+\z/, message: "は全角文字を使用してください" }
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナ文字を使用してください" }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナ文字を使用してください" }
  validates :birthdate, presence: true
end
