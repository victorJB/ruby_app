require 'rails_helper'

RSpec.describe 'Invoices', type: :request do
  describe 'POST /create' do
    context 'with valid parameters' do
      let!(:invoice_test) { FactoryBot.create(:invoice) }

      before do
        post '/invoices', params:
                          { invoice: {
                            status: invoice_test.status,
                            emitter_name: invoice_test.emitter_name,
                            emitter_rfc: invoice_test.emitter_rfc,
                            receiver_name: invoice_test.receiver_name,
                            receiver_rfc: invoice_test.receiver_rfc,
                            amount_type: invoice_test.amount_type,
                            cents: invoice_test.cents,
                            currency: invoice_test.currency,
                            emitted_at: invoice_test.emitted_at,
                            expires_at: invoice_test.expires_at,
                            signed_at: invoice_test.signed_at,
                            cfdi_digital_stamp: invoice_test.cfdi_digital_stamp,
                          } }
      end

      it 'returns the status' do
        expect(json['status']).to eq(invoice_test.status)
      end

      it 'returns the emitter_name' do
        expect(json['emitter_name']).to eq(invoice_test.emitter_name)
      end

      it 'returns the emitter_rfc' do
        expect(json['emitter_rfc']).to eq(invoice_test.emitter_rfc)
      end

      it 'returns the receiver_name' do
        expect(json['receiver_name']).to eq(invoice_test.receiver_name)
      end

      it 'returns the receiver_rfc' do
        expect(json['receiver_rfc']).to eq(invoice_test.receiver_rfc)
      end

      it 'returns the amount_type' do
        expect(json['amount_type']).to eq(invoice_test.amount_type)
      end

      it 'returns the cents' do
        expect(json['cents']).to eq(invoice_test.cents)
      end

      it 'returns the currency' do
        expect(json['currency']).to eq(invoice_test.currency)
      end

      it 'returns the emitted_at' do
        expect(json['emitted_at'].to_date).to eq(invoice_test.emitted_at.to_date)
      end

      it 'returns the expires_at' do
        expect(json['expires_at'].to_date).to eq(invoice_test.expires_at.to_date)
      end

      it 'returns the signed_at' do
        expect(json['signed_at'].to_date).to eq(invoice_test.signed_at.to_date)
      end

      it 'returns the cfdi_digital_stamp' do
        expect(json['cfdi_digital_stamp']).to eq(invoice_test.cfdi_digital_stamp)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end
    end
  end
end