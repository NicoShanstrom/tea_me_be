require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:subscriptions).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:address) }
    
    it 'validates uniqueness of email case insensitively' do
      Customer.create!(
        first_name: 'Nico',
        last_name: 'Shantii',
        email: 'WOLF@Toddler.com',
        address: '3398 old haleakala hwy'
      )
      customer = Customer.new(
        first_name: 'Nico',
        last_name: 'Shantii',
        email: 'wolf@toddler.com',
        address: '3398 old haleakala hwy'
      )

      expect(customer).not_to be_valid
      expect(customer.errors[:email]).to include('has already been taken')
    end
  end

  describe 'callbacks' do
    it 'downcases email before saving' do
      customer = Customer.new(first_name: "Nico", last_name: "Shantii", email: "NICOSHANTII@GMAIL.com", address: '398 sand hill rd')
      customer.save
      expect(customer.reload.email).to eq("nicoshantii@gmail.com")
    end
  end
end
