FactoryBot.define do
  factory :payment_request_transliteration, class: 'Transliteration::PaymentRequestTransliteration' do
    sequence(:id)
    sequence(:payment_request_id)
    field_name { 'field_name' }
    original_text { 'original_text' }
    transliterated_text { 'transliterated_text' }
    source_locale { 'en' }
    target_locale { 'el' }
  end
end
