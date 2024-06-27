class Api::V1::Customers::SubscriptionsController < ApplicationController
  def index
    subscriptions = Subscription.where(customer_id: params[:customer_id])
    render json: SubscriptionSerializer.new(subscriptions).serializable_hash.to_json
  end
end