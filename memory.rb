# keeps track of variables

class Memory
    attr_accessor :vars
    
    # TODO: make it a singleton or something like that?
    def initialize
        vars = {}
    end

    def new_var(name, value)
        if !name.instance_of?(String)
            bad_name_fail
        end

        if !value.is_a?(Type)
            bad_value_fail
        end
    end

    def bad_name_fail
        puts "Given name is not valid"
        exit 1
    end
    
    def bad_value_fail
        puts "Given value is not valid"
        exit 1
    end

end

class Var
    attr_reader :val

    def initialize
        if !value.is_a?(Type)
            bad_value_fail
        end
        
    end
    
    
    end
