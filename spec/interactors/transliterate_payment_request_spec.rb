require 'rails_helper'

RSpec.describe Transliteration::Interactors::TransliteratePaymentRequest, type: :unit do
  let(:transliteration_params) do
    {
      payment_request_id: 1,
      field_name: 'field_name',
      original_text: 'original_text',
      source_locale: 'el',
      target_locale: 'en'
    }
  end

  subject { described_class.call(transliteration_params) }

  describe "#.call(payment_request_id:, field_name:, original_text:, source_locale:, target_locale:)" do
    let(:contract) { spy('Transliteration::CreatePaymentRequestTransliterationContract') }
    let(:contract_result) { spy('Dry::Validation::Result') }
    let(:payment_request_transliteration) { FactoryBot.build(:payment_request_transliteration) }

    before do
      allow(Transliteration::CreatePaymentRequestTransliterationContract).to receive(:new) { contract }
      allow(contract).to receive(:call) { contract_result }
      allow(Transliteration::PaymentRequestTransliteration).to receive(:create) { payment_request_transliteration }
    end

    context "when the validation has errors" do
      before do
        allow(contract_result).to receive(:failure?) { true }
      end

      it 'should be an error and not create a payment request transliteration' do
        result = subject
        expect(result.failure?).to be_truthy
        expect(result.error).to be_present
        expect(Transliteration::PaymentRequestTransliteration).to_not have_received(:create)
      end
    end

    context "when the validation does not have errors" do
      before do
        allow(contract_result).to receive(:failure?) { false }
      end

      context "and the payment request transliteration object has errors" do
        before do
          allow(payment_request_transliteration).to receive(:invalid?) { true }
        end

        it 'should be an error' do
          result = subject
          expect(result.failure?).to be_truthy
          expect(result.error).to be_present
          expect(Transliteration::PaymentRequestTransliteration).to have_received(:create).with(
            payment_request_id: transliteration_params[:payment_request_id],
            field_name: transliteration_params[:field_name],
            original_text: transliteration_params[:original_text],
            transliterated_text: transliteration_params[:original_text]
                                   .localize(transliteration_params[:source_locale])
                                   .transliterate_into(transliteration_params[:target_locale]),
            source_locale: transliteration_params[:source_locale],
            target_locale: transliteration_params[:target_locale]
          )
        end
      end

      context "and the payment request transliteration object does not have errors" do
        before do
          allow(payment_request_transliteration).to receive(:invalid?) { false }
        end

        it 'should create the payment request transliteration object and return success' do
          result = subject
          expect(result.success?).to be_truthy
          expect(result.error).to_not be_present
          expect(Transliteration::PaymentRequestTransliteration).to have_received(:create).with(
            payment_request_id: transliteration_params[:payment_request_id],
            field_name: transliteration_params[:field_name],
            original_text: transliteration_params[:original_text],
            transliterated_text: transliteration_params[:original_text]
                                   .localize(transliteration_params[:source_locale])
                                   .transliterate_into(transliteration_params[:target_locale]),
            source_locale: transliteration_params[:source_locale],
            target_locale: transliteration_params[:target_locale]
          )

          transliteration = result.transliteration
          expect(transliteration.id).to eq(payment_request_transliteration.id)
          expect(transliteration.payment_request_id).to eq(payment_request_transliteration.payment_request_id)
          expect(transliteration.field_name).to eq(payment_request_transliteration.field_name)
          expect(transliteration.original_text).to eq(payment_request_transliteration.original_text)
          expect(transliteration.transliterated_text).to eq(payment_request_transliteration.transliterated_text)
          expect(transliteration.source_locale).to eq(payment_request_transliteration.source_locale)
          expect(transliteration.target_locale).to eq(payment_request_transliteration.target_locale)
        end
      end
    end
  end
end
