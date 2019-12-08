require_relative "../lib/champions.rb"
require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
    attr_accessor :champions_url, :all_champs
    BASE_PATH = "https://leagueoflegends.fandom.com"
         

    def initialize
      #  lolwiki = "https://leagueoflegends.fandom.com/wiki"
        @champions_url = []
        @all_champs = {:name => [], :title => [], :class_type => [], :abilities => {}}
       
    end

    def getChamps
      #  BASE_PATH,champions,all_champs
        site = Nokogiri::HTML(open(BASE_PATH + "/wiki/List_of_champions"))
        #site.css("table.wikitable.sortable tr td:first").each {|x| puts x.attribute("data-sort-value").text}
        #site.css("table.wikitable.sortable tr td:first a").each {|x| puts x.attribute("href").value}
        

        site.css("table.wikitable.sortable").each { |champ|
            champ.css("tr td:first").each_with_index { |names,index|
               @all_champs[:name] << names.attribute("data-sort-value").value
                # @all_champs[:name][index] = names.attribute("data-sort-value").value
            }
            champ.css("tr td[2] span").each.with_index(0) { |types,index| 
                @all_champs[:class_type] << types.attribute("data-param").text 
            }      
            champ.css("tr td:first span:first:first a:first:first").each {|url| 
                @champions_url << url.attribute("href").text 
            } 
            champ.css("tr td:first span:first:first a:first:last").each {|url|
                @all_champs[:title] << url.text
                @all_champs[:title].delete("")
            }
        }

           # binding.pry
            getChampAbilities
            #binding.pry
            createChampions
            
           
    end

    def getChampAbilities
       # @champions_url.uniq
       # binding.pry
        temp =""
       
       #binding.pry
       @champions_url.uniq.each.with_index(0) { |champ, index|
         champ_site = Nokogiri::HTML(open(BASE_PATH + "#{champ}/Abilities"))
            #puts champ_site.title
            @all_champs[:abilities][:"#{@all_champs[:name][index]}"] = []
            temp = "#{@all_champs[:name][index]}"
                champ_site.css(".skill .ability-info-container").each.with_index(0) { |ability,index| 
                  
                @all_champs[:abilities][:"#{temp}"] << ability.css("tr td p").text
            }
             }
    end

    def createChampions
            temp = ""
            binding.pry
        @all_champs.each.with_index(0) { |champ,index| 
            temp = champ[:name][index]
            Champion.new(champ[:name][index], champ[:title][index], champ[:class_type][index], champ[:abilities][:"#{temp}"])
        }
    end

        
end #end of class 
