class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :shipping_address

  validates_associated :shipping_address
end
