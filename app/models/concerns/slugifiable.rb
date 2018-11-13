module Slugifiable
    module InstanceMethods
        def slug 
            self.name.parameterize
        end
    end 

    module ClassMethods
        def find_by_slug(slug)
            self.all.detect {|o| o.name.parameterize == slug}
        end
    end
end