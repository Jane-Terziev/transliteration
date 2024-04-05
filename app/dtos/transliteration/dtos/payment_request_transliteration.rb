module Transliteration
  module Dtos
    class PaymentRequestTransliteration < Dry::Struct
      attribute :id, ::Types::Integer
      attribute :payment_request_id, ::Types::Integer
      attribute :field_name, ::Types::String
      attribute :original_text, ::Types::String
      attribute :transliterated_text, ::Types::String
      attribute :source_locale, ::Types::String
      attribute :target_locale, ::Types::String
    end
  end
end