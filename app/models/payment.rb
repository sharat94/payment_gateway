class Payment < ActiveRecord::Base
	after_create :convert_to_encryption

	def convert_to_encryption
		bank_details= "bank_ifsc_code=#{self.bank_ifsc_code}|bank_account_number=#{self.bank_account_number}|amount=#{self.amount}|merchant_transaction_ref=#{self.merchant_transaction_ref}|transaction_date=#{self.transaction_date}|payment_gateway_merchant_reference=#{self.payment_gateway_merchant_reference}"
		payload_with_sha=Digest::SHA1.hexdigest(bank_details)
		bank_details= "#{bank_details}|hash=#{payload_with_sha}"
		secure_aes_bank_details = secure_file_aes(bank_details)
		secure_base_bank_details = secure_file_base(secure_aes_bank_details)
		response = "#{secure_base_bank_details}"
		new_response = check_response(response)
		expected_response = generate_response()
		if new_response == expected_response
			self.status ="success"
			self.message = "#{new_response}"
			self.save
		else
			self.status ="failiure!"
			self.message = "#{new_response}"
			self.save
		end
	end

	def secure_file_aes(data)
		cipher = OpenSSL::Cipher::AES128.new(:CBC)
		cipher.encrypt
		cipher.key= Key.last.main_key
		cipher.iv = Key.last.main_iv
		encrypted = cipher.update("#{data}") + cipher.final
		return encrypted
	end

	def secure_file_base(data)
		puts "entered secure_file_base"
		base_encrypt = Base64.encode64(data)
		return base_encrypt
	end

	def check_response(data)
		base_item = Base64.decode64(data)
		decipher = OpenSSL::Cipher::AES128.new(:CBC)
		decipher.decrypt
		decipher.key = Key.last.main_key
		decipher.iv = Key.last.main_iv
		plain = decipher.update("#{base_item}") + decipher.final
		return plain
	end
	def generate_response()
		bank_details= "bank_ifsc_code=#{self.bank_ifsc_code}|bank_account_number=#{self.bank_account_number}|amount=#{self.amount}|merchant_transaction_ref=#{self.merchant_transaction_ref}|transaction_date=#{self.transaction_date}|payment_gateway_merchant_reference=#{self.payment_gateway_merchant_reference}"
		payload_with_sha=Digest::SHA1.hexdigest(bank_details)
		bank_details= "#{bank_details}|hash=#{payload_with_sha}"
		return bank_details
	end

end
