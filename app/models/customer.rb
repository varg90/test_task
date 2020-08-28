class Customer < ApplicationRecord
  validates :email, uniqueness: true,
            format: { with: /\A[^@\s]+@[^@\s]+\z/i }
end
