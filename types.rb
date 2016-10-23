# this file is for types! types types types


# What do we want a type to do?
# It should only allow certain values, literal and variable.
# It should be have certain operations.

class Type
    attr_accessor :val

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
            val = true
        elsif str == "false"
            val = false
        else
            type_fail
        end
    end
end

class Integ < Type
    def initialize(input)
        num = input.to_i
        if num.to_s != input
            type_fail
            return
        end
        val = num
    end
end

# TODO: strings are hard; lets think about them later
class Str < Type
    def initialize(input)
        val = input
    end
end

