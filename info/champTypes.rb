require_relative "../lib/CLI.rb"
require_relative "../lib/champions.rb"
module ChampTypes
   
    def self.getNames
        self.all
    end

    def find_by_name(name)
        self.all.detect {|champ| champ.name}
    end
end