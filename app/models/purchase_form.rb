# app/models/purchase_form.rb
class PurchaseForm
  include ActiveModel::Model

  attr_accessor :item_id, :quantity, :buyer_id, :shipping_address_attributes, :payment_method

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :payment_method, presence: true

  # shipping_address_attributesに関連する属性を設定
  def shipping_address_attributes=(attributes)
    @shipping_address_attributes = ShippingAddress.new(attributes)
  end

  with_options presence: true do
    validates :shipping_address_attributes
    validates :shipping_address_attributes, format: { with: /\A\d{3}-\d{4}\z/, message: 'は「3桁ハイフン4桁」の形式で入力してください' }, if: -> { shipping_address_attributes.present? && shipping_address_attributes[:postal_code].present? }
    validates :shipping_address_attributes, numericality: { only_integer: true }, if: -> { shipping_address_attributes.present? && shipping_address_attributes[:postal_code].present? }
    validates :shipping_address_attributes, inclusion: { in: Prefecture.all.map(&:id) }, if: -> { shipping_address_attributes.present? && shipping_address_attributes[:prefecture_id].present? }
    validates :shipping_address_attributes, length: { maximum: 255 }, if: -> { shipping_address_attributes.present? && shipping_address_attributes[:city].present? }
    validates :shipping_address_attributes, length: { maximum: 255 }, if: -> { shipping_address_attributes.present? && shipping_address_attributes[:street_address].present? }
    validates :shipping_address_attributes, length: { maximum: 255 }, if: -> { shipping_address_attributes.present? && shipping_address_attributes[:building_name].present? }
    validates :shipping_address_attributes, format: { with: /\A\d{10,11}\z/, message: 'は10桁以上11桁以内の半角数値のみ入力してください' }, if: -> { shipping_address_attributes.present? && shipping_address_attributes[:phone_number].present? }
  end

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      purchase = Purchase.new(
        item_id: item_id,
        quantity: quantity,
        buyer_id: buyer_id,
        payment_method: payment_method
      )
      purchase.save!

      # 購入記録に紐づく発送先情報を保存
      purchase.create_shipping_address(shipping_address_attributes.to_h)
    end

    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end

