module Transliteration
  module Interactors
    class TransliteratePaymentRequest
      include Interactor

      delegate :payment_request_id, :field_name, :original_text, :source_locale, :target_locale, to: :context

      after do
        # maybe use https://github.com/Jane-Terziev/dry_object_mapper to map active record object to dtos, instead of
        # mapping the fields manually?
        context.transliteration = Dtos::PaymentRequestTransliteration.new(
          id: @transliteration.id,
          payment_request_id: @transliteration.payment_request_id,
          field_name: @transliteration.field_name,
          original_text: @transliteration.original_text,
          transliterated_text: @transliteration.transliterated_text,
          source_locale: @transliteration.source_locale,
          target_locale: @transliteration.target_locale
        )
      end

      def call
        validate_params
        save_payment_request_transliteration
      end

      private

      def validate_params
        result = CreatePaymentRequestTransliterationContract.new.call(context.to_h)
        context.fail!(error: ApiErrors::ValidationError.new(result.errors.to_h)) if result.failure?
      end

      def save_payment_request_transliteration
        return if context.failure?

        @transliteration = PaymentRequestTransliteration.create(
          payment_request_id: payment_request_id,
          field_name: field_name,
          original_text: original_text,
          transliterated_text: original_text.localize(source_locale).transliterate_into(target_locale),
          source_locale: source_locale,
          target_locale: target_locale
        )

        context.fail!(error: ApiErrors::ValidationError.new(@transliteration.errors.full_messages)) if @transliteration.invalid?
      end
    end
  end
end