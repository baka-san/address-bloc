require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - View a specific entry number"
    puts "3 - Create an entry"
    puts "4 - Search for an entry"
    puts "5 - Import entries from a CSV"
    puts "6 - Exit"
    # print for no new line
    print "Enter your selection: "

    selection = gets.to_i

    case selection
      when 1
        system "clear"
        view_all_entries
        main_menu
      when 2
        system "clear"
        search_entry_number
        main_menu
      when 3
        system "clear"
        create_entry
        main_menu
      when 4
        system "clear"
        search_entries
        main_menu
      when 5
        system "clear"
        read_csv
        main_menu
      when 6
        puts "Good-bye!"
        exit(0)
      else
        system "clear"
        puts "Sorry, that is not a valid input"
        main_menu
    end
  end


  def view_all_entries

    # Iterate through all entries
    address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s

      # View a submenu for each entry with options
      entry_submenu(entry)
    end
    
    system "clear"
    puts "End of entries"
  end

  def search_entry_number
    print "Please enter the entry number: "

    number = gets.to_i 
    system "clear"

    entry = address_book.entries[number]
    
    if entry 
      puts entry.to_s

      # View a submenu for each entry with options
      entry_submenu(entry)
    else
      puts "Sorry, that's not a valid entry!"
      search_entry_number
    end
  end
  
  def create_entry
    puts "New AddressBloc Entry"
    print "Name: "
    name = gets.chomp
    print "Phone number: "
    phone = gets.chomp
    print "Email: "
    email = gets.chomp

    address_book.add_entry(name, phone, email)

    system "clear"
    puts "New entry created"
  end
  
  def search_entries
  end
  
  def read_csv
  end

  def entry_submenu(entry)
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
  
    selection = gets.chomp
  
    case selection
      when "n"
      when "d"
      when "e"
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        entry_submenu(entry)
    end
  end
end