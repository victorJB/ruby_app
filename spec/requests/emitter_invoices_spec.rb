require 'rails_helper'

RSpec.describe 'Invoices', type: :request do
  describe 'GET /emitter_invoices' do
    let!(:invoice_test) { FactoryBot.create(:invoice) }
    before do
      get "/invoices/emitter_invoices?emitter_rfc="+invoice_test.emitter_rfc
    end
    
    it 'returns all invoices' do
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end