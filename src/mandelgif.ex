defmodule MandelGif do
    
    def create_image(x0, y0, xn, width, height, depth) do
        
    end

    def create_gif(x0, y0, xn, step, width, height, depth) do
        xn =
            case xn >= x0 do
                true -> -xn
                false -> xn
            end
        step =
            case step >= 0 do
                true -> step 
                false -> -step
            end
        name = "#{x0}x#{y0}ys#{xn}z"
        [foldername | _] = String.split(name, "s")
        File.mkdir("./images")
        File.mkdir("./images/#{foldername}")
        File.mkdir("./ppms")
        File.mkdir("./ppms/#{foldername}")
        IO.puts "Computing Images, this will take a while"
        gif(x0, y0, xn, step, width, height, depth, xn)
    end

    def gif(x0, y0, xn, step, width, height, depth, xstart) do
        signed_total_amount = round((x0-xstart)/step)
        total_amount = 
            case signed_total_amount >= 0 do
                true -> signed_total_amount
                false -> -signed_total_amount
            end
        current_number = String.rjust(Integer.to_string(round((xn-xstart)/step)), Kernel.length(Integer.digits(total_amount)), ?0)
        name = "#{x0}x#{y0}ys#{current_number}z"
        case xn >= x0 do
            true -> 
                [foldername | _] = String.split(name, "s")
                IO.puts "Converting Images to a gif"
                port = Port.open({:spawn, "magick convert -delay 4 -loop 0 ./images/#{foldername}/*.png ./images/#{foldername}/#{foldername}.gif"}, [])
                Port.close(port)
                IO.puts "Complete, ./images/#{foldername}/#{name}.gif"
            false ->
                k = (xn - x0) / width
                IO.puts "[#{current_number}/#{total_amount}] Images calculated..."
                image = Mandel.mandelbrot(width, height, x0, y0, k, depth)
                PPM.write(name, image)
                gif(x0, y0, xn + step, step, width, height, depth, xstart)
            end
    end

    def zero_fill(total_amount, current_number) do
        to_fill = Kernel.length(Integer.digits(total_amount)) - Kernel.length(Integer.digits(current_number))
        fill(current_number, to_fill)
    end

    def fill(current_number, 0) do current_number end
    def fill(current_number, to_fill) do
        fill("0" + current_number, to_fill - 1)
    end

end