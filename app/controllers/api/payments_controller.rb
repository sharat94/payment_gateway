module Api
	
		class Api::PaymentsController < ApplicationController
			
			def index

				#say message is true
				bank_details= "txn_status=success|amount=10000|merchant_transaction_ref=txn001|transaction_date=#{Date.today}|payment_gateway_merchant_reference=merc001|payment_gateway_transaction_reference=pg_txn_001"
				payload_with_sha=Digest::SHA1.hexdigest(bank_details)
				bank_details= "#{bank_details}|hash=#{payload_with_sha}"
				cipher = OpenSSL::Cipher::AES128.new(:CBC)
				cipher.encrypt
				key= Key.last.main_key
				iv = Key.last.main_iv
				encrypted = cipher.update(bank_details) + cipher.final
				base_encrypt = Base64.encode64(encrypted)

			  	render :json => base_encrypt , status: 201
			end

			 
			
		end
	
end
