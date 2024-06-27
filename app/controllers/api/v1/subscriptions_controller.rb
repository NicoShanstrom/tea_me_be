class Api::V1::SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.new(subscription_params)

    if subscription.save
      render json: SubscriptionSerializer.new(subscription).serializable_hash.to_json, status: :created
    else
      render json: { errors: format_errors(subscription.errors) }, status: :unprocessable_entity
    end
  end

  def destroy
    subscription = Subscription.find(params[:id])
    subscription.update(status: 1)
    render json: { message: "Subscription canceled successfully" }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "Couldn't find Subscription" }, status: :not_found
  end

  def show
    subscription = Subscription.find(params[:id])
    render json: SubscriptionSerializer.new(subscription).serializable_hash.to_json
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "Couldn't find Subscription" }, status: :not_found
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
  end
end