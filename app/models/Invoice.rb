class Invoice < ApplicationRecord

    def self.get_invoices(params)
        query = params[:status].present? ? "status = '#{params[:status]}'" : ""
        query += params[:emitter_rfc].present? ? (query.length > 0 ? " AND emitter_rfc = '#{params[:emitter_rfc]}'" : "emitter_rfc = '#{params[:emitter_rfc]}'") : ""
        query += params[:receiver_rfc].present? ? (query.length > 0 ? " AND receiver_rfc = '#{params[:receiver_rfc]}'" : "receiver_rfc = '#{params[:receiver_rfc]}'") : ""
        query += params[:amount_min].present? ? (query.length > 0 ? " AND CAST(cents AS DECIMAL) >= #{params[:amount_min].to_f}" : "CAST(cents AS DECIMAL) >= #{params[:amount_min].to_f}") : ""
        query += params[:amount_max].present? ? (query.length > 0 ? " AND CAST(cents AS DECIMAL) <= #{params[:amount_max].to_f}" : "CAST(cents AS DECIMAL) <= #{params[:amount_max].to_f}") : ""

        @invoices = Invoice.where(query)
    end

    def self.get_user_invoices(params)
        query = "emitter_rfc = '#{params[:emitted_rfc]}'"
        query += params[:emitted_at].present? ? " AND emitted_at = '#{params[:emitted_at]}'" : ""

        @invoices = Invoice.where(query)
    end
end
