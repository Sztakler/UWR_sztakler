class Jawna 
    @napis = ""

    def initialize(napis)
        @napis = napis
    end

    def to_s
        @napis
    end

    def zaszyfruj(klucz)
        res = ""
        @napis.split("").each{|l|
            if (klucz.key?(l))
                res += klucz[l]
            else 
                res += l
            end
        }
        Zaszyfrowane.new(res)
    end
end



class Zaszyfrowane
    @napis = ""

    def initialize(napis)
        @napis = napis
    end

    def to_s
        @napis
    end

    def odszyfruj(klucz)
        res = ""
        k = klucz.invert
        @napis.split("").each{|l|
            if (k.key?(l))
                res += k[l]
            else 
                res += l
            end
        }
        Jawna.new(res)
    end

end


klucz = {
    'a'=> 'ą',
    'ą'=> 'b',
    'b'=>'c',
    'c'=>'ć',
    'ć'=> 'd',
    'd'=>'e',
    'e'=>'ę',
    'ę'=> 'f',
    'f'=>'g',
    'g'=>'h',
    'h'=>'i',
    'i'=>'j',
    'j'=>'k',
    'k'=>'l',
    'l'=>'ł',
    'ł'=>'m',
    'm'=>'n',
    'n'=>'ń',
    'ń'=>'o',
    'o'=>'ó',
    'ó'=>'p',
    'p'=>'r',
    'r'=>'s',
    's'=>'ś',
    'ś'=>'t',
    't'=>'u',
    'u'=>'x',
    'x'=>'y',
    'y'=>'z',
    'z'=>'ź',
    'ź'=>'ż',
    'ż'=>'a'
}

napis = Jawna.new("abecadło")
napis_zaszyfrowany = napis.zaszyfruj(klucz)
napis_odszyfrowany = napis_zaszyfrowany.odszyfruj(klucz)

puts "Napis:              #{napis}"
puts "Napis zaszyfrowany: #{napis_zaszyfrowany}"
puts "Napis odszyfrowany: #{napis_odszyfrowany}"

# test_arr = [5, 1, 3, 0, 2, 4]
# print "Array:                 " ,test_arr, "\n"
# print "Array sorted:          " ,test_arr.sort, "\n"
# print "Array:                 " ,test_arr, "\n"
# print "Array sorted in place: " ,test_arr.sort!, "\n"
# print "Array:                 " ,test_arr, "\n"