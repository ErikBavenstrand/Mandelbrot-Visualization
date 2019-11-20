
defmodule Brot do

    
    def mandelbrot(c, m) do
        z0 = Cmplx.new(0, 0)
        i = 0
        test(i, z0, c, m)
    end

    #Recursively test the value z0 and see if it exceeds 2 in the max iterations m
    def test(i, _, _, i) do i end
    def test(i, z0, c, m) do
        case Cmplx.abs(z0) do
            #If z is greater than 2 it will go to infinity
            z when z > 2 -> i
            _ -> test(i + 1, Cmplx.add(Cmplx.sqr(z0), c), c, m) #z(n+1) = z(n)^2 + z0  
        end
    end

end