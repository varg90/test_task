class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items
  accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true

  validates :number, :date, presence: true

  def total
    order_items.sum do |order_item|
      order_item.quantity * order_item.item.price
    end
  end
end
