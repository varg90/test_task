class CmcApiDatum < ApplicationRecord
  validates :endpoint, uniqueness: true
  validates :data, presence: true
end
