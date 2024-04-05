require 'rails_helper'

RSpec.describe Transliteration::CreatePaymentRequestTransliterationContract, type: :unit do
  let(:transliteration_params) do
    {
      payment_request_id: 1,
      field_name: 'field_name',
      original_text: 'original_text',
      source_locale: 'el',
      target_locale: 'en'
    }
  end

  subject { described_class.new }

  describe "#.call(params)" do
    context "when a required parameter is missing" do
      %w[payment_request_id field_name original_text source_locale target_locale].each do |field|
        it 'should return failure' do
          expect(subject.call(transliteration_params.except(field.to_sym)).success?).to be_falsey
        end
      end
    end

    context "when passing an unsupported source locale" do
      it 'should return failure' do
        transliteration_params[:source_locale] = 'invalid'
        expect(subject.call(transliteration_params).success?).to be_falsey
      end
    end

    context "when passing an unsupported target locale" do
      it 'should set the interactor as failed' do
        transliteration_params[:target_locale] = 'invalid'
        expect(subject.call(transliteration_params).success?).to be_falsey
      end
    end

    context "when all the parameters are valid" do
      it 'should not raise an error' do
        expect(subject.call(transliteration_params).success?).to be_truthy
      end
    end
  end
end
