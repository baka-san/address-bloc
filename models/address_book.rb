require_relative 'entry'
require 'csv'

class AddressBook
	attr_reader :entries

	def initialize
		@entries = []
	end


	def add_entry(name, phone_number, email)

	  index = 0

	  @entries.each do |entry|

	    if name < entry.name
	      break
	    end

	    index+= 1
	  end

	  @entries.insert(index, Entry.new(name, phone_number, email))  
	end


	def remove_entry(name, phone_number, email)

		entry_to_delete = nil

		@entries.each do |entry|

			if name == entry.name && phone_number == entry.phone_number \
			&& email == entry.email

				entry_to_delete = entry
				break

			end
		end

		@entries.delete(entry_to_delete)
	end

	def import_from_csv(file_name)
		puts Dir.pwd
		csv_text = File.read(file_name)
		csv = CSV.parse(csv_text, headers: true, skip_blanks: true)

		csv.each do |row|
		  row_hash = row.to_hash
		  add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
		end
	end

end