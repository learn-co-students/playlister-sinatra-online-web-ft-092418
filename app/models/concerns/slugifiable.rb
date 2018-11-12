module Slugifiable
    module InstanceMethods
        def slug 
            self.name.downcase.gsub(" ","-")
        end
    end 

    module ClassMethods
        def find_by_slug
            @name = self.find_by(name: params[:name])
            @name.slug
        end
    end
end