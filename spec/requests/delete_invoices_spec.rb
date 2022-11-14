require 'rails_helper'

RSpec.describe 'Invoices', type: :request do
  describe "DELETE /destroy" do
    let!(:invoice) { FactoryBot.create(:invoice) }

    before do
      delete "/invoices/#{invoice.id}"
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end