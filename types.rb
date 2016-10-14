# this file is for types! types types types


# What do we want a type to do?
# It should only allow certain values, literal and variable.
# It should be have certain operations.

class Type
    # setters and getters for the value
    def get_val
        return @val
    end

    def set_val(v)
        @val = v
    end

    # print that the type is wrong and
    # what it should have been, and exit
    def type_fail
        puts
        puts "Mismatched types!"
        puts "Given type should be a #{self.class}"
        puts

        exit 1
    end
end

class Bool < Type
    def initialize(input)
        if str == "true"
            @val = true
        elsif str == "false"
            @val = false
        else
            type_fail
        end
    end
end

class Integ < Type
    def initialize(input)
        num = str.to_i
        if num.to_s != str
            type_fail
        end
    end
end

class Str < Type
    def initialize(input)
        
    end
end
