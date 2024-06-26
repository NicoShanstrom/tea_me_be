require 'rails_helper'

RSpec.describe 'API V1 Subscriptions', type: :request do
  let!(:customer) { create(:customer) }
  let!(:tea) { create(:tea) }
  let!(:subscription1) { create(:subscription, title: 'Monthly Tea', customer: customer, tea: tea, status: 0) }
  let!(:subscription2) { create(:subscription, title: 'Weekly Tea', customer: customer, tea: tea, status: 1) }
  let(:valid_attributes) { { subscription: { title: 'Monthly Tea', price: 10.0, status: 0, frequency: 1, customer_id: customer.id, tea_id: tea.id } } }
  let(:invalid_attributes) { { subscription: { title: '', price: '', status: 0, frequency: 1, customer_id: '' , tea_id: tea.id } } }

  describe 'POST /api/v1/subscriptions' do
    context 'when the request is valid' do
      before { post '/api/v1/subscriptions', params: valid_attributes }

      it 'creates a subscription' do
        expect(json['data']['type']).to eq('subscription')
        expect(json['data']['attributes']['title']).to eq('Monthly Tea')
        expect(json['data']['attributes']['price']).to eq('10.0')
        expect(json['data']['attributes']['status']).to eq('active')
        expect(json['data']['attributes']['frequency']).to eq(1)
        expect(json['data']['relationships']['customer']['data']['id']).to eq(customer.id.to_s)
        expect(json['data']['relationships']['customer']['data']['type']).to eq('customer')
        expect(json['data']['relationships']['tea']['data']['id']).to eq(tea.id.to_s)
        expect(json['data']['relationships']['tea']['data']['type']).to eq('tea')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/subscriptions', params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expected_error_message = "Customer must exist, Title can't be blank, Price can't be blank, Price is not a number"
        expect(json['errors']).to eq(expected_error_message)
      end
    end
  end

  describe 'DELETE /api/v1/subscriptions/:id' do
    context 'when the subscription exists' do
      before { delete "/api/v1/subscriptions/#{subscription1.id}" }

      it 'cancels the subscription' do
        expect(response).to have_http_status(204)
        expect(subscription1.reload.status).to eq(1)
      end
    end

    context 'when the subscription does not exist' do
      before { delete "/api/v1/subscriptions/0" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
        expect(json['errors']).to eq("Couldn't find Subscription")
      end
    end
  end

  describe 'GET /api/v1/subscriptions/:id' do
    context 'when the subscription is canceled' do
      let!(:canceled_subscription) { create(:subscription, title: 'Monthly Tea', customer: customer, tea: tea, status: 1) }

      before { get "/api/v1/subscriptions/#{canceled_subscription.id}" }

      it 'returns the subscription with status canceled' do
        expect(response).to have_http_status(200)
        expect(json['data']['attributes']['status']).to eq('canceled')
      end
    end
  end

  describe 'GET /api/v1/subscriptions' do
    context 'when the customer has subscriptions' do
      before { get "/api/v1/subscriptions", params: { customer_id: customer.id } }

      it 'returns all subscriptions for the customer' do
        expect(response).to have_http_status(200)
        expect(json['data'].size).to eq(2)
        expect(json['data'][0]['attributes']['title']).to eq('Monthly Tea')
        expect(json['data'][1]['attributes']['title']).to eq('Weekly Tea')
      end
    end

    context 'when the customer has no subscriptions' do
      let!(:new_customer) { create(:customer) }

      before { get "/api/v1/subscriptions", params: { customer_id: new_customer.id } }

      it 'returns an empty array' do
        expect(response).to have_http_status(200)
        expect(json['data']).to eq([])
      end
    end
  end
end
