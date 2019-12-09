require_relative "../lib/scraper.rb"
require_relative "../lib/CLI.rb"
require_relative "../info/champTypes.rb"

class Champion
    extend ChampTypes::ClassMethods
   
    attr_accessor :name, :title, :role, :abilities
    @@all = []

    def initialize(name,title,role)
        @name = name
        @title = title
        @role = role 
        @abilities = []
        @@all << self
       
    end

    def self.all
        @@all
    end

end #end of class
