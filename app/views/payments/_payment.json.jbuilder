json.extract! payment, :id, :bank_ifsc_code, :bank_account_number, :amount, :merchant_transaction_ref, :transaction_date, :payment_gateway_merchant_reference, :payload_with_sha, :payload_to_pg, :created_at, :updated_at
json.url payment_url(payment, format: :json)