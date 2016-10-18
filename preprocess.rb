# This class grabs the code from the file
# and does the initial parsing.
# It tells the user to try again if they
# didn't comment enough or had any
# uppercase letters.

COMMENT_CHAR = "#"
REQUIRED_COMMENT_PERCENTAGE = 0.15

class FirstPass
    @filepath
    @line_list
    @heres
    @comment_counter
    @num_non_code_lines
    @is_file_read

    def initialize(filepath)
        @filepath = filepath
        @line_list = []
        @heres = {}
        # lets us figure out if they have written enough comments
        @comment_counter = 0
        @num_non_code_lines = 0
        @file_is_read = false
    end

    def process_file
        return @line_list if @file_is_read
        File.open(@filepath, "r") do |f|
            f.each_line.with_index do |line, index|
                # remove newline
                line = line.chomp
                line_is_blank = line == ""
                @num_non_code_lines += 1 if line_is_blank
                if !line_is_blank && !mark_if_comment(line)
                    fail_if_uppercase(line)
                    @line_list.push([line, index])
                end
                handle_if_here(line, index)
            end
        end
        fail_if_too_few_comments
        @file_is_read = true
        return @line_list, @heres
    end

    def mark_if_comment(line)
        well_does_it = line.start_with?(COMMENT_CHAR)
        if well_does_it
            @comment_counter += 1
            @num_non_code_lines += 1
        end
        return well_does_it
    end

    def handle_if_here(line, index)
        arr = line.split(" ")
        if arr[0] == "here"
            if arr.length > 2
                fail_too_many_tokens(2, index + 1)
            end
            if @heres[arr[1]]
                fail_redundant_here
            end
            # associate the name with the place in the code
            @heres[arr[1]] = get_internal_index(index)
        end
    end

    # get the internal representation of a line number
    # from the actual line number of the file
    def get_internal_index(index)
        return index - @num_non_code_lines
    end

    def fail_too_many_tokens(max_tokens, line_number)
        puts
        puts "Too many tokens on line #{line_number} ."
        puts "The maximum number of tokens"
        puts "for this statement is #{max_tokens}."
        puts
        exit 1
    end

    def fail_redundant_here
        puts
        puts "You can't have more than one"
        puts "here with the same name!"
        puts
        exit 1
    end

    def fail_if_too_few_comments
        num_lines = @line_list.size
        percent_comments = (1.0 * @comment_counter) / (1.0 * num_lines)
        if percent_comments < REQUIRED_COMMENT_PERCENTAGE
            puts
            puts "Not enough comments!"
            puts "Your code must be a least 15% comments by line"
            puts
            exit 1
        end
    end

    def fail_if_uppercase(str)
        if str =~ /[A-Z]/
            puts
            puts "You used an uppercase character!"
            puts str
            puts "SHAME on you for this disgrace."
            puts
            exit 1
        end
    end
end

if __FILE__ == $0
    first_pass = FirstPass.new(ARGV[0])
    lines = first_pass.process_file
    p lines
end
