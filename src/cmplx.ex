#Handles representing a complex number
defmodule Cmplx do
    #Returns the complex number with real value r and imaginary i
    def new(r, i) do
        {r, i}
    end

    #Adds two complex numbers
    def add({r_1, i_1}, {r_2, i_2}) do
        {r_1 + r_2, i_1 + i_2}
    end

    #Squares a complex number
    def sqr({r, i}) do
        {r * r - i * i, 2 * r * i}
    end

    #The absolute value of a
    def abs({r, i}) do
        :math.sqrt(r * r + i * i)
    end
end