class Payment < ActiveRecord::Base
	before_create :convert_to_encryption

	def convert_to_encryption
		bank_details= "bank_ifsc_code=#{self.bank_ifsc_code}|bank_account_number=#{self.bank_account_number}|amount=#{self.amount}|merchant_transaction_ref=#{self.merchant_transaction_ref}|transaction_date=#{self.transaction_date}|payment_gateway_merchant_reference=#{self.payment_gateway_merchant_reference}"
		self.payload_with_sha=Digest::SHA1.hexdigest(bank_details)
		bank_details= "#{bank_details}|hash=#{self.payload_with_sha}"
		secure_aes_bank_details = secure_file_aes(bank_details)
		secure_base_bank_details = secure_file_base(secure_aes_bank_details)
	end

	def secure_file_aes(data)
		cipher = OpenSSL::Cipher::AES128.new(:CBC)
		cipher.encrypt
		key= cipher.random_key
		iv = cipher.random_iv
		encrypted = cipher.update(data) + cipher.final
		return encrypted
	end

	def secure_file_base(data)
		base_encrypt = Base64.encode64(data)
		return base_encrypt
	end


end
