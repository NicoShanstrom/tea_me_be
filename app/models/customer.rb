class Customer < ApplicationRecord
  has_many :subscriptions, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true 
  validates :address, presence: true

  before_save :downcase_email

  private
    
  def downcase_email
    self.email = email.downcase
  end
end

