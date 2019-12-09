require_relative "../lib/CLI.rb"
require_relative "../lib/champions.rb"
require "pry"
module ChampTypes
   module ClassMethods
        def all
             self.all
        end
        
        def find_by_name(name, abilities = nil)
            self.all.detect { |champ| 
            if champ.name == name
                return champ
            end
            }
        end

        def find_by_role(role)
            champs_with_role = []
            self.all.select { |champ| 
            if champ.role == role 
                champs_with_role << champ
            end
            }
            return champs_with_role
        end
        
        def list_all_roles
            self.all.collect { |champ|
                champ.role
        }.uniq.sort
        end
    end    
end