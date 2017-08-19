class Payment < ActiveRecord::Base
	after_create :convert_to_encryption

	def convert_to_encryption
		bank_details= "bank_ifsc_code=#{self.bank_ifsc_code}|bank_account_number=#{self.bank_account_number}|amount=#{self.amount}|merchant_transaction_ref=#{self.merchant_transaction_ref}|transaction_date=#{self.transaction_date}|payment_gateway_merchant_reference=#{self.payment_gateway_merchant_reference}"
		payload_with_sha=Digest::SHA1.hexdigest(bank_details)
		bank_details= "#{bank_details}|hash=#{payload_with_sha}"
		puts bank_details
		secure_aes_bank_details = secure_file_aes(bank_details)
		puts "this is secure_aes_bank_details #{secure_aes_bank_details}"
		secure_base_bank_details = secure_file_base(secure_aes_bank_details)
		puts "this is secure_base_bank_details #{secure_base_bank_details}"
		response = "vmnOOnoeXOBBNUGfAxx36jVRv8tDKGaRuAl0RCFu3tojNzFtA6DdDrlQdCR3 HsabSkNKUG0cAxHORg7l4rQtL0iGwJCUpbCkq5LA8u7MuoXvoQPdSbI25gjw lXfbSoaR4pBU9j0Qzux7fVqGLXIZ+gvbkPFiaM9KGP8yzZQ0pyJj801RIvga /RM++Q7fYNH/Z9ZGFNK9uPTMDWUm5+uJ6Z+M9ZRM0f925Lh6m+GYY1Ya7sou qhxiKauFZiA60ushLpGy/XxEC0tzyPod8MEOmB9HzRU3YHv0YiYxyAQ9mKS1 5r0VHO1g04pXrbMFR6Ms"
			puts response
		new_response = check_response(response)
		expected_response = generate_response()
		puts response
		puts expected_responses
		if new_response == expected_response
			self.status ="success"
			self.message = "#{response}"
			self.save
		else
			self.status ="failiure!"
			self.message = "#{response}"
			self.save
		end
	end

	def secure_file_aes(data)
		puts "entered secure_file_aes"
		cipher = OpenSSL::Cipher::AES128.new(:CBC)
		cipher.encrypt
		key= Key.last.main_key
		iv = Key.last.main_iv
		encrypted = cipher.update(data) + cipher.final
		return encrypted
	end

	def secure_file_base(data)
		puts "entered secure_file_base"
		base_encrypt = Base64.encode64(data)
		return base_encrypt
	end

	def check_response(data)
		puts "entered check_response"
		base_decrypt = Base64.decode64(data)
		puts "data check"
		decipher = OpenSSL::Cipher::AES.new(128, :CBC)
		decipher.decrypt
		puts "before check"
		puts Key.last.main_key
		puts "after_check"
		puts Key.last.main_iv
		decipher.key = Key.last.main_key
		decipher.iv = Key.last.main_iv
		plain = decipher.update(base_decrypt) + decipher.final
		return plain
	end
	def generate_response()
		puts "entered generate response"
		bank_details= "txn_status=success|amount=#{self.amount}|merchant_transaction_ref=#{self.merchant_transaction_ref}|transaction_date=#{self.transaction_date}|payment_gateway_merchant_reference=#{self.payment_gateway_merchant_reference}|payment_gateway_transaction_reference=pg_txn_001"
		payload_with_sha=Digest::SHA1.hexdigest(bank_details)
		bank_details= "#{bank_details}|hash=#{payload_with_sha}"
		puts bank_details
		return bank_details
	end

end
