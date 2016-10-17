require 'thread'

class DoSomething
    def doitHere
        puts "Do it, bro!"
    end
    
    def doitThere
        puts "Do it there, bro!"
    end
end

it = DoSomething.new

Thread.new do 
    it.doitThere
end

sleep 1

it.doitHere

sleep 100

