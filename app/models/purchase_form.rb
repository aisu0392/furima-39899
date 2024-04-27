# app/models/purchase_form.rb
class PurchaseForm
  include ActiveModel::Model

  attr_accessor :item_id, :user_id, :shipping_address, :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number, :token

   # バリデーションの追加
   with_options presence: true do
    validates :token, presence: { message: "を入力してください。" }
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'が無効です。次のように入力してください。 (例 123-4567)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください。" }
    validates :city
    validates :street_address
    validates :phone_number, format: { with: /\A[0-9]+\z/, message: 'が無効です。数字のみ入力してください。' }, length: { minimum: 10, maximum: 11, too_short: 'が短すぎます。', too_long: 'が長すぎます。' }
  end


  
  validates :user_id, presence: { message: "must exist" }
  validates :item_id, presence: { message: "must exist" }


  def user
    User.find_by(id: user_id)
  end

  def item
    Item.find_by(id: item_id)
  end

  

  def save
    return false unless valid?
    
    # 購入記録の保存
    purchase = Purchase.create!(item_id: item_id,user_id: user_id)

    # 購入記録に紐づく発送先情報の保存
    purchase.create_shipping_address(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      street_address: street_address,
      building_name: building_name,
      phone_number: phone_number
    )

    true
  rescue ActiveRecord::RecordInvalid
    false
  end



end

