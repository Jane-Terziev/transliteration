module Transliteration
  module Facades
    class Transliteration
      def transliterate_payment_request(payment_request_id:, field_name:, original_text:, source_locale:, target_locale:)
        Interactors::TransliteratePaymentRequest.call(
          payment_request_id: payment_request_id,
          field_name: field_name,
          original_text: original_text,
          source_locale: source_locale.to_s,
          target_locale: target_locale.to_s
        )
      end
    end
  end
end