defmodule Mandel do
    
    def mandelbrot(width, height, x, y, k, depth) do
        trans = fn(w, h) -> Cmplx.new(x + k * (w - 1), y - k * (h - 1)) end

        rows(width, height, trans, depth, [])
    end

    def rows(_, 0, _, _, row_list) do row_list end
    def rows(width, height, trans, depth, row_list) do
        color_row = row(width, height, trans, depth, [])
        rows(width, height - 1, trans, depth, [color_row | row_list])
    end

    def row(0, _, _, _, current_row) do current_row end
    def row(width, height, trans, depth, current_row) do
        color = Color.convert(Brot.mandelbrot(trans.(width, height), depth), depth)
        row(width - 1, height, trans, depth, [color | current_row])
    end

    def demo() do
    small(-0.761101, -0.09, -0.75)
    end
    def small(x0, y0, xn) do
        width = 1080
        height = 720
        depth = 64
        k = (xn - x0) / width
        image = Mandel.mandelbrot(width, height, x0, y0, k, depth)
        PPM.write("#{x0}x_#{y0}y_#{xn}z.ppm", image)
    end
end