require 'set'
require './preprocess.rb'
require './memory.rb'

# the set of special keywords
KEYWORDS = Set.new ["here", "go", "int",
    "bool", "string", "embiggen", "ensmallen",
    "addem", "subem", "multem", "divem",
    "==", "<", ">", "<=", ">=", "print", "augh"]

def wrong_type_fail
    puts
    puts "You used the wrong type!!!"
    puts
    exit 1
end

def fail_on_wrong_type(val, type)
    if !val.is_a?(type)
        wrong_type_fail
    end
end

$KEYMAPPING = {
    "here" => lambda {|line|},
    "go" => lambda {|name|
            $prog_count = $heres[name]
        },
    "int" => lambda {|name, value|
            newInt = Integ.new(value)
            $memory.new_var(name, newInt)
        },
    "bool" => lambda {|name, value|
            newBool = Bool.new(value)
            $memory.new_var(name, newBool)
        },
    "string" => lambda {|name, value|
            newString = Str.new(value)
            $memory.new_var(name, newString)
        },
    "embiggen" => lambda {|name|
            # gets and deletes value
            val = $memory.get_val(name)
            fail_on_wrong_type(val, Integ)
            val += 1
            # set the value and reset its timer
            $memory.new_var(name, val)
        },
    "ensmallen" => lambda {|name|
            val = $memory.get_val(name)
            fail_on_wrong_type(val, Integ)
            val -= 1
            $memory.new_var(name, val)
        },
    "addem" => lambda {|res, name1, name2|
            val1 = $memory.get_val(name1)
            fail_on_wrong_type(val1, Integ)
            val2 = $memory.get_val(name2)
            fail_on_wrong_type(val2, Integ)
            result = val1 + val2
            $memory.new_var(res, result)
        },
        
}

# this class tokenizes each line
class Tokenizer
    def initialize(line)
        line_arr = split_line(line)
    end

    def split_line(line)
       return line.split(" ")
    end

    # TODO: come back to this later
    def handle_string(line, line_arr)
        name = line_arr[1]
    end
end


# do the stuff

def interpret(filename)
    first_pass = FirstPass.new(ARGV[0])
    lines, heres = first_pass.process_file
    p lines
    puts
    puts
    p heres
    
    # set up the memory
    $memory = Memory.new

    # find where all the here statements are, and what
    # their names are
    # TODO: start interpreting the file

    # program counter
    $prog_count = 0
    while $prog_count < lines.length
        
        $prog_count += 1
    end

end


if __FILE__ == $0
    if ARGV.length == 0
        puts "You gotta gimme an input file!"
        puts "Please do that."
        exit
    end

    interpret(ARGV[0])
end

