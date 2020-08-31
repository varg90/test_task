class Customer < ApplicationRecord
  validates :email, uniqueness: true,
            format: { with: /\A[^@\s]+@[^@\s]+\z/i }
  validates :birthdate, presence: true
  validate :allowed_to_order_alcohol

  has_many :orders, dependent: :destroy

  def allowed_to_order_alcohol
    if birthdate > 21.years.from_now
      errors.add(:birthdate, 'Grow up and come back! Sorry')
    end
  end

  def total_amount
    orders.sum &:total
  end
end
