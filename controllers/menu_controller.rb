require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - Exit"
    puts "6 - Shit, the cops are here! Nuke the book!"
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
        create_entry
        main_menu
      when 3
        system "clear"
        search_entries
        main_menu
      when 4
        system "clear"
        read_csv
        main_menu
      when 5
        puts "Good-bye!"
        exit(0)
      when 6
        system "clear"
        nuke_book 
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
  
  def create_entry
    system "clear"
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
    print "Search by name: "
    name = gets.chomp
    match = address_book.binary_search(name)
    system "clear"

    if match
      puts match.to_s
      entry_submenu(match)
    else
      puts "No match found for #{name}"
    end
  end
  
  def read_csv
    print "Enter CSV file to import: "
    file_name = gets.chomp
    
    # #2
    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end
    
    # #3
    begin
      entry_count = address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
      read_csv
    end
  end

  def nuke_book
    print "Are you sure you want to delete everything? (Y/n)"
    selection = gets.chomp

    if(selection == 'Y')
      @address_book.nuke
      system "clear"
      puts "All entries deleted."
      main_menu
    elsif(selection == 'n')
      system "clear"
      puts "Nuke aborted."
      main_menu
    else
      system "clear"
      puts "Not a valid entry."
      main_menu
    end
  end

  def entry_submenu(entry)
    puts "n - next entry"
    puts "p - previous entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
  
    selection = gets.chomp.downcase
  
    case selection
      when "n"
      when "p"
      when "d"
        delte_entry(entry)
        main_menu
      when "e"      
        edit_entry(entry)
        entry_submenu(entry)
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        puts entry.to_s
        entry_submenu(entry)
    end
  end

  def delte_entry(entry)
    print "Are you sure you want to delete #{entry.name}? (Y/n)"
    selection = gets.chomp

    if(selection == 'Y')
      @address_book.entries.delete(entry)
      system "clear"
      puts "#{entry.name} has been deleted"
    elsif(selection == 'n')
      system "clear"
      puts "Entry was not deleted."
      puts entry.to_s
      entry_submenu(entry)
    else
      system "clear"
      puts "Not a valid entry."
      puts entry.to_s
      entry_submenu(entry)
    end
  end

  def edit_entry(entry)
    print "Updated name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp

    entry.name = name unless name.empty?
    entry.phone_number = phone_number unless phone_number.empty?
    entry.email = email unless email.empty?
    system "clear"

    puts "Updated entry:"
    puts entry
  end

end