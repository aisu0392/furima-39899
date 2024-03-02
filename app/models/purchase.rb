class Purchase < ApplicationRecord
  attr_accessor :token
  belongs_to :user
  belongs_to :item
  has_one :shipping_address

  validates :token, presence: true
  validates_associated :shipping_address
end
