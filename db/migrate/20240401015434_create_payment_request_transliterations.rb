class CreatePaymentRequestTransliterations < ActiveRecord::Migration[7.1]
  def change
    create_table :transliteration_payment_request_transliterations do |t|
      t.bigint :payment_request_id
      t.string :field_name
      t.text :original_text
      t.text :transliterated_text
      t.string :source_locale
      t.string :target_locale

      t.timestamps
    end
  end
end
