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
    @comment_counter
    @is_file_read

    def initialize(filepath)
        @filepath = filepath
        @line_list = []
        # lets us figure out if they have written enough comments
        @comment_counter = 0
        @file_is_read = false
    end

    def process_file
        return @line_list if @file_is_read
        File.open(@filepath, "r") do |f|
            f.each_line do |line|
                # remove newline
                line = line.chomp
                if line != "" && !mark_if_comment(line)
                    fail_if_uppercase(line)
                    @line_list.push(line)
                end
            end
        end
        fail_if_too_few_comments
        @file_is_read = true
        return @line_list
    end

    def mark_if_comment(line)
        well_does_it = line.start_with?(COMMENT_CHAR)
        @comment_counter += 1 if well_does_it
        return well_does_it
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

