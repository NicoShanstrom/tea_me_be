require 'rails_helper'

RSpec.describe 'API V1 Subscriptions', type: :request do
  let!(:customer) { create(:customer) }
  let!(:tea) { create(:tea) }
  let(:valid_attributes) { { subscription: { title: 'Monthly Tea', price: 10.0, status: 0, frequency: 1, customer_id: customer.id, tea_id: tea.id } } }
  let(:invalid_attributes) { { subscription: { title: '', price: '', status: 0, frequency: 1, customer_id: '' , tea_id: tea.id } } }

  describe 'POST /api/v1/subscriptions' do
    context 'when the request is valid' do
      before { post '/api/v1/subscriptions', params: valid_attributes }

      it 'creates a subscription' do
        # require 'pry'; binding.pry
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
        # require 'pry'; binding.pry
        expected_error_message = "Customer must exist, Title can't be blank, Price can't be blank, Price is not a number"
        expect(json['errors']).to eq(expected_error_message)
      end
    end
  end
end
