class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :status, :frequency

  attribute :status do |subscription|
    subscription.status == 0 ? 'active' : 'canceled'
  end
  
  belongs_to :customer
  belongs_to :tea
end
