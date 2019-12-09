require_relative "../lib/champions.rb"
require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
    attr_accessor :champions_url, :all_champs
    BASE_PATH = "https://leagueoflegends.fandom.com"
         

    def initialize
        @champions_url = []
        @all_champs = {:name => [], :title => [], :role => []} 
        
       
    end

    def getChamps
        site = Nokogiri::HTML(open(BASE_PATH + "/wiki/List_of_champions"))

        site.css("table.wikitable.sortable").each { |champ|
            champ.css("tr td:first").each_with_index { |names,index|
               @all_champs[:name] << names.attribute("data-sort-value").value
            }
            champ.css("tr td[2] span").each.with_index(0) { |types,index| 
                @all_champs[:role] << types.attribute("data-param").text 
            }      
            champ.css("tr td:first span:first:first a:first:first").each {|url| 
                @champions_url << url.attribute("href").text 
            } 
            champ.css("tr td:first span:first:first a:first:last").each {|url|
                @all_champs[:title] << url.text
                @all_champs[:title].delete("")
            }
        }
           
       # getChampAbilities("Aatrox")
        #getChamps
        createChampions
        #binding.pry
           
    end
    
    def createChampions
        temp = ""
        index = 0 
        while index < @all_champs[:name].size do
            temp = @all_champs[:name][index]
            Champion.new(temp, @all_champs[:title][index], @all_champs[:role][index])   
            index +=1
        end
    end

    def getChampAbilities(name)
        abilities = []
        puts name
        
        if name.include?("'")
            name = "/wiki/" << name.gsub("'","%27")
        elsif name.include?(" ")
            name = "/wiki/" << name.gsub(" ","_")
        elsif name.include?(".")
            name = "/wiki/" << name.gsub(".","._")
        else 
            name = "/wiki/" << name
        end
       
        if @champions_url.uniq.include?(name)
            champ_site = Nokogiri::HTML(open(BASE_PATH + "#{name}/Abilities"))
            puts champ_site.title
            champ_site.css(".skill .ability-info-container").each.with_index(0) { |ability,index|    
                 abilities << ability.css("tr td p").text
        }
            return appendKeys(abilities)   
        else    
            puts "Champion not found!"
        end 
    end

    def appendKeys(array)
        array[0].prepend("  ")
        array[1].prepend("  Q:  ")
        array[2].prepend("  W:  ")
        array[3].prepend("  E:  ")
        array[4].prepend("  R:  ")
        return array
    end
end #end of class 


