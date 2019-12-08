require_relative "../lib/scraper.rb"
require_relative "../lib/champions.rb"
require 'pry'

class CLI 
    def run
        scraper = Scraper.new
        input = ""
        while input!="exit"
           
            puts "Learn about each League of Legends Champions!"
            puts "1: List Champion Classes and choose from them"
            puts "2: Find a Champion by first letter"
            puts "3: List ALL Champions"
                #considering adding gameplay information and terms 
            puts "4: Exit"

            input = gets.strip.to_i


            case input
                when 1 
                    puts "List Champion Classes and choose from them"
                when 2
                    puts "Find a champion by first letter"
                when 3
                    puts "List ALL champions by name"
                    scraper.getChamps
                    Student.all
                when 4
                    puts "exit"
                    break
            end
        
        end #end of while

    end #end of run

    


end #end of CLI class