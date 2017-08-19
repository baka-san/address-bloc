class Entry
	attr_accessor :name, :phone_number, :email 

	def initialize(name, phone_number, email)
		@name = name
		@phone_number = phone_number
		@email = email
	end

	def to_s
		puts "Name: #{@name} \n" \
		"Phone Number: #{@phone_number}\n" \
    "Email: #{@email}" 
	end
end