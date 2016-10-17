require './preprocess.rb'

# do the stuff

def interpret(filename)
    first_pass = FirstPass.new(ARGV[0])
    @lines, @heres = first_pass.process_file
    # find where all the here statemens are, and what
    # their names are
    # TODO: start interpreting the file
end


if __FILE__ == $0
    if ARGV.length == 0
        puts "You gotta gimme an input file!"
        puts "Please do that."
        exit
    end

    interpret(ARGV[0])
end
