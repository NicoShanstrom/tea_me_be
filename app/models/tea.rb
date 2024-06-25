class Tea < ApplicationRecord
  has_many :subscriptions, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :temperature, presence: true
  validates :brew_time, presence: true
end

