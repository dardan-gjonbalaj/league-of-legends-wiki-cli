require_relative "../lib/scraper.rb"
require_relative "../lib/CLI.rb"
require 'open-uri'
#require nokogiri

class Champion
    attr_accessor :name, :title, :class_type, :style, :abilities 
    @@all = []

    def initialize(name,title,class_type,abilities)
        @name = name
        @title = title
        @class_type = class_type 
        @abilities = abilities
        @@all << self
    end

    def self.all
        @@all
    end

end #end of class


#STYLE should include Damage Type(AD or AP), and according to the wiki page wheel 
##champion-container > table > tbody > tr:nth-child(2) > td:nth-child(2) > aside > section > svg > g.stat-wheel-section.stat-wheel-damage
#if you look at the code in the wheel, the bars indicate either : stat-wheel-bar OR stat-wheel-bar-lit
#consider using this when describing the style ie Damage, Toughness, Control, Mobility, Utility
# @@ALL << all the champs  

#name & title
#list_of_champs.css("table.wikitable.sortable tr td a").attribute("title").value

#webpage for champ
#list_of_champs.css("table.wikitable.sortable tr td a").attribute("href").value

#class_type
#list_of_champs.css("table.wikitable.sortable tr td[2] a").attribute("href").value
#list_of_champs.css("table.wikitable.sortable tr td[2] span").attribute("data-param").value
#site.css("table.wikitable.sortable tr td[2] span").each {|x| puts x.attribute("data-param").text}


#The_Darkin_Blade > table:nth-child(2) > tbody > tr:nth-child(1) > td:nth-child(2) > p
#/html/body/div[3]/section/div[2]/article/div[1]/div[1]/div[2]/div[3]/div[2]/div[1]/div[4]/div/div/table[2]/tbody/tr[1]/td[2]/p

#abilities - passive, ability 1, ability 2, ability 3, ultimate
#div class skill skill_innate , div class skill skill_q, div class skill skill_e, div class skill skill_r

#Deathbringer_Stance > table:nth-child(2) > tbody
##champion-container > table > tbody > tr:nth-child(1) > td > table > tbody > tr:nth-child(2) > td > span > span