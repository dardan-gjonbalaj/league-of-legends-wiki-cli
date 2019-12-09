require_relative "../lib/scraper.rb"
require_relative "../lib/champions.rb"
require_relative "../info/champTypes.rb"
require 'pry'


class CLI 
    attr_reader :scraper
    
    def initialize
        @scraper = Scraper.new
    end

    def run
        scraper.getChamps
        champion = Champion      
        input = ""
        while input!="exit"
           
            puts "| Learn about each League of Legends Champions! "
            puts "| 1: List Champion Classes and choose from them "
            puts "| 2: Find a Champion by name "
            puts "| 3: List ALL Champions"
            puts "| 4: Exit"
            #items, gameplay mechanics and terms might be a kind of useless in CLI 
            
            input = gets.strip.to_i

            case input
                when 1 
                    puts "List Champion Classes and choose from them"
                        champs_by_role
                when 2
                    puts "Find a champion by name"
                        find_champ                    
                when 3
                    puts "List ALL champions by name"
                        show_all_champs
                when 4
                    puts "....Exiting! \n "
                    break
            end
        
        end #end of while
    end #end of run

    def show_all_champs
        Champion.all.each { |champ|  puts champ.title }
        end
    
    def find_champ(name =nil)
        if name == nil
            name = gets.strip
        end
        temp = nil
           
        if temp = Champion.find_by_name(name.gsub(/\w+/, &:capitalize))
            if temp.abilities.empty?
                getAbilities = getAbilities(temp.name) 
                temp.abilities << getAbilities
            end
            puts "     ______________________________________"
            puts "            #{temp.title}   "
            puts "     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"   
               
            puts temp.abilities.flatten.flatten
            puts "\n"
            
        else
             puts "   \n   Champion not found!   \n "
        end
    end

    def champs_by_role
        get_roles = []
        get_roles = Champion.list_all_roles
            get_roles.each.with_index(1) { |x,y| puts "#{y}: #{x}"}
            puts "Select which role"
        input = gets.strip.to_i
            #if input > 0 || input <= temp.size SHOULD ADD A CHECK 
        role = get_roles[input-1] 
         
        get_roles = Champion.find_by_role(role)
        get_roles.each.with_index(1) { |champ,index|
            puts "#{index}: #{champ.name} " 
                if champ.abilities.empty?
                    champ.abilities << getAbilities(champ.name)
                end
        }
        puts " \n Would you like to select a champ from this list? yes/no \n"
            choice = gets.strip
            if choice == "yes" || choice == "1" || choice == "y"
                puts "Which number?"
                num = gets.strip.to_i
                num = 1 if num <= 0 || num > get_roles.size
                puts Champion.find_by_name(get_roles[num-1].name).title
                find_champ(Champion.find_by_name(get_roles[num-1].name).name)
            end
    end

    def getAbilities(name)
        scraper.getChampAbilities(name)
    end

    

end #end of CLI class