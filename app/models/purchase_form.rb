# app/models/purchase_form.rb
class PurchaseForm
  include ActiveModel::Model

  attr_accessor :item_id, :user_id, :quantity, :buyer_id, :payment_method, :shipping_address, :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number

   # バリデーションの追加
   with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city, presence: true
    validates :street_address, presence: true
    validates :phone_number, format: { with: /\A[0-9]+\z/, message: 'is invalid. Input only number' }, length: { minimum: 10, allow_blank: true, message: 'is too short' }
  end

  validates :building_name, length: { maximum: 255 }

  

  def save
    return false unless valid?

    # 購入記録の保存
    purchase = Purchase.create!(
      item_id: item_id,
      quantity: quantity,
      buyer_id: buyer_id,
      payment_method: payment_method
    )

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

