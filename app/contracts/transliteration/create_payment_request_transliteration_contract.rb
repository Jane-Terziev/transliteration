module Transliteration
  class CreatePaymentRequestTransliterationContract < Dry::Validation::Contract
    SUPPORTED_LOCALES_MAPPING = %w[en el].freeze

    params do
      required(:payment_request_id).filled(:int?)
      required(:field_name).filled(:str?)
      required(:original_text).filled(:str?)
      required(:source_locale).filled(:str?)
      required(:target_locale).filled(:str?)
    end

    rule(:source_locale, :target_locale) do
      key(:source_locale).failure(
        'Unsupported source locale!'
      ) unless SUPPORTED_LOCALES_MAPPING.include?(values[:source_locale])

      key(:target_locale).failure(
        'Unsupported target locale!'
      ) unless SUPPORTED_LOCALES_MAPPING.include?(values[:target_locale])
    end
  end
end
