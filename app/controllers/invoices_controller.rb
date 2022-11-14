class InvoicesController < ApplicationController
    before_action :set_invoice, :authenticate_user!
    skip_before_action :set_invoice, only: [:create, :index, :emitter_invoices]

    # GET /invoices
    def index
        @invoices = Invoice.get_invoices(params)
        
        render json: {
            total: @invoices.count,
            data: @invoices
        }
    end

    # GET /invoices/uuid
    def show
        render json:@invoice
    end
    
    # POST /invoices
    def create
        @invoice = Invoice.new(invoice_params)
        
        if @invoice.save
            XmlHelper.save_xml(@invoice, @invoice.id)
            render json: @invoice, status: :created, location: @invoice
        else
            render json: @invoice.errors, status: :unprocessable_entity
        end
    end
    
    # DELETE /invoices/uuid
    def destroy
        @invoice.destroy
        XmlHelper.delete_xml(params[:id])
    end

    # PUT /invoices/uuid
    def update
        if @invoice.update(invoice_params)
            XmlHelper.save_xml(@invoice, params[:id])
            render json: @invoice
        else
            render json: @invoice.errors, status: :unprocessable_entity
        end
    end

    # GET /emitter_invoices
    def emitter_invoices
        @invoices = Invoice.get_user_invoices(params)
        render json: @invoices
    end

    private

    def set_invoice
        @invoice = Invoice.find(params[:id])
    end

    def invoice_params
      params.require(:invoice).permit(:status, :emitter_name, 
                    :emitter_rfc, :receiver_name, :receiver_rfc, :amount_type,
                    :cents, :currency, :emitted_at, :expires_at, 
                    :signed_at, :cfdi_digital_stamp)
    end
end
