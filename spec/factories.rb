FactoryBot.define do
    factory :invoice do
        status { 'active' }
        emitter_name { FFaker::NameMX.full_name }
        emitter_rfc { FFaker::IdentificationMX.rfc_persona_moral }
        receiver_name { FFaker::NameMX.full_name }
        receiver_rfc { FFaker::IdentificationMX.rfc_persona_moral }
        amount_type { 'integer' }
        cents { rand(1_000_000) }
        currency { FFaker::Currency.code }
        emitted_at { FFaker::Time.date }
        expires_at { FFaker::Time.date }
        signed_at { FFaker::Time.date }
        cfdi_digital_stamp { FFaker::DizzleIpsum.characters }
    end
  end