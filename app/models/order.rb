class Order < ApplicationRecord
  belongs_to :customer

  validates :number, :date, presence: true

  def total
    # TODO: replace it with items.sum &:cost
    id * 100
  end
end
