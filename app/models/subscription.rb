class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true, inclusion: { in: [0, 1] } # assuming 0: active, 1: canceled
  validates :frequency, presence: true, numericality: { only_integer: true, greater_than: 0 }
end

