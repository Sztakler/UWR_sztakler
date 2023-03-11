class Function  

    @function

    def initialize(definition)
        @function = definition
    end

    def value(x)
        @function.call(x)
    end

    def zeroes(a, b, e)
        zeroes_array = []
        if (value(0) == 0) 
            zeroes_array.push(0)
        end
        find_roots = Proc.new {|a, b|
            x0 = (a + b) / 2.0
            if (b - a <= e)
                if (value(a) * value(b) < 0)
                    zeroes_array.push(x0)
                end
            else
                find_roots.(a, x0)
                find_roots.(x0, b)
            end  
        }

        find_roots.(a, b)
        return zeroes_array
    end

    def area(a, b)
        points = []
        area = 0
        i = 0.0
        n = (100*(b-a).abs()).to_i
        until i > n do
            points.push(a + (i/n * (b - a)))
            i += 1.0
        end

        area += (value(points[0]) + value(points[n])) / 2.0

        j = 1
        while (j < n)
            area += value(points[j]) 
            j += 1
        end
        
        return area * (b - a) / n
    end

    def derivative(x)
        dx = 0.00001

        return (value(x + dx) - value(x)) / dx
    end

     
    def plot(a, b)
    
            open("plot.txt", 'w') do |f|
    
                f.puts "x y"
                i = 0.0
                n = (1000*(b-a).abs()).to_i
                until i > n do
                    new_x = a + (i/n * (b - a))
                    f.puts "#{new_x} #{value(new_x)}"
                    i += 1.0
                end
            end
        end

end 
    



polynomial = Function.new(Proc.new {|x| x*x*x - x*x + 0.001})
sinc = Function.new(Proc.new {|x| x == 0? 1 : Math.sin(x)/x})

print "Value of sin(1) =            ", sinc.value(1), "\n"
print "Zeroes of sin in [-7, 7] =   ", sinc.zeroes(-7, 7, 0.01), "\n"
print "Area of sin in [0:PI] =      ", sinc.area(0, Math::PI), "\n"
print "Value of sin'(1) =           ", sinc.derivative(1), "\n"
sinc.plot(-4*Math::PI, 4*Math::PI)

    #   set style line 1 \
    # linecolor rgb '#0060ad' \
    # linetype 1 linewidth 2 \
    # pointtype 7 pointsize 0.1 