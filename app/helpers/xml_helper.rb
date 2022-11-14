require 'builder'
require 'fileutils'

module XmlHelper
    def self.generate_xml(invoice,invoice_uuid)
        xml = Builder::XmlMarkup.new( indent: 2 )
        xml.instruct! :xml, encoding: "UTF-8", version: '1.0'
        xml.hash do |hash|
          hash.invoice_uuid invoice_uuid
          hash.status invoice.status
          hash.emitter do |emitter|
            emitter.name invoice.emitter_name
            emitter.rfc invoice.emitter_rfc
          end
          hash.receiver do |receiver|
            receiver.name invoice.receiver_name
            receiver.rfc invoice.receiver_rfc
          end
          hash.amount do |amount|
            amount.comment! 'eg. 1234 cents = 12.34'
            amount.cents invoice.cents, type: invoice.amount_type
            amount.comment! 'ISO 4217'
            amount.currency invoice.currency
          end
          hash.emitted_at invoice.emitted_at, type: 'date'
          hash.expires_at invoice.expires_at, type: 'date'
          hash.signed_at invoice.signed_at, type: 'date'
          hash.cfdi_digital_stamp invoice.cfdi_digital_stamp, type: 'text'
        end
    end

    def self.save_xml(invoice, uuid)
        invoice_uuid = uuid.present? ? uuid : SecureRandom.uuid
        File.open("public/20220811012132-invoices/#{invoice_uuid}.xml", 'w') do |f|
        f.write(generate_xml(invoice,invoice_uuid))
        end
    end
    
    def save_xml(invoice, uuid)
        XmlHelper.save_xml(invoice, uuid)
    end

    def generate_xml(invoice,invoice_uuid)
        XmlHelper.generate_xml(invoice)
    end

    def self.delete_xml(uuid)
        FileUtils.rm_rf("public/20220811012132-invoices/#{uuid}.xml") 
    end

    def delete_xml(uuid)
        XmlHelper.delete_xml(invoice)
    end
end