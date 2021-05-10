class Integer
    def czynniki
        arr = []
        self.times {|t|
            if (self % (t+1) == 0)
                arr << (t+1)
            end 
        }
        arr
    end


    def ack(y)
        if (self == 0)
            y + 1
        elsif (y == 0)
            (self-1).ack(1)
        else
            (self-1).ack(self.ack(y-1))
        end
    end


    def ❤️
        if (self == self.czynniki.sum-self)
            true
        else 
            false
        end
    end


    def 🂱
        num_to_s = { 
            '0' => 'zero',
            '1' => 'jeden',
            '2' => 'dwa',
            '3' => 'trzy',
            '4' => 'cztery',
            '5' => 'pięć',
            '6' => 'sześć',
            '7' => 'siedem',   
            '8' => 'osiem',
            '9' => 'dziewięć'}
        
        slowo = ""
        self.to_s.split("").each{ |l| slowo += num_to_s[l] + " "}
        slowo

    end
end

print 6.czynniki

puts 

puts 2.ack(1)

puts 6.❤️

puts 123.🂱