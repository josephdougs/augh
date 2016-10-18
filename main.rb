require 'set'
require './preprocess.rb'

# the set of special keywords
KEYWORDS = Set.new ["here", "go", "int",
    "bool", "string", "yep", "nope", "embiggen",
    "print", "augh"]


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
    # find where all the here statements are, and what
    # their names are
    # TODO: start interpreting the file

    # program counter
    $prog_count = 0
    while $prog_count < lines.length

        prog_count += 1
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

