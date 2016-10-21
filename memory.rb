require 'thread'

# keeps track of variables

# variables live for fifteen minutes
VARIABLE_LIFETIME = 60 * 15


class Memory
    # TODO: make it a singleton or something like that?
    def initialize
        @vars = {}
    
        # start a new thread to kill old variables
        Thread.new do
            while true
                # loop through vars and delete ones
                # that have been around too long
                @vars.each do |name, var|
                    now = Time.now.to_i
                    if now >= var.kill_time
                        @vars.delete(name)
                    end
                end
            end
        end
    end

    def new_var(name, value)
        if !name.instance_of?(String)
            bad_name_fail
        end

        @vars[name] = Var.new(value)
    end

    def get_var(name)
        if !@vars[name]
            nil_var_fail
        end
        return @vars[name]
    end

    def bad_name_fail
        puts
        puts "Given name is not valid"
        puts
        exit 1
    end

    def nil_var_fail
        puts
        puts "No variable with the name: #{name} found."
        puts
        exit 1
    end
end

class Var
    attr_reader :val, :kill_time
    def new(val)
        if !value.is_a?(Type)
            bad_value_fail
        end

        @val = val
        @time_created = Time.now.to_i + VARIABLE_LIFETIME
    end

    def bad_value_fail
        puts "Given value is not valid"
        exit 1
    end
end
