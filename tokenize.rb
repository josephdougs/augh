require 'set'

# the set of special keywords
KEYWORDS = Set.new ["here", "go", "int",
    "bool", "string", "yep", "nope", "embiggen",
    "print", "augh"]


# this class tokenizes each line
class Tokenizer
    def split_line(line)
       return line.split(" ") 
    end

    # TODO: come back to this later
    def handle_string(line, line_arr)
        name = line_arr[1]
    end
end



