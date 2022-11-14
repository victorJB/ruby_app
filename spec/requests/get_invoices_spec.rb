require 'rails_helper'

RSpec.describe 'Invoices', type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create_list(:invoice, 5)
      get '/invoices'
    end
    
    it 'returns all invoices' do
      expect(json['data'].size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end