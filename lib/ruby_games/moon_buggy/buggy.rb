class RubyGames::MoonBuggy::Buggy
    def initialize(x, y, color = 'lime')
        @vy = 0
        # buggy frame
        h = 15  # height
        w = 200 # width
        @y0 = y # baseline y-position
        @body_floor = Rectangle.new(x: x, y: @y0, width: w, height: h, color: 'gray')
        @body_sides = [
            Triangle.new(x1: x+120, y1: @y0, x2: x+120, y2: @y0-30, x3: x,   y3: @y0, color: 'gray'), # back
            Triangle.new(x1: x+120, y1: @y0, x2: x+120, y2: @y0-30, x3: x+w, y3: @y0, color: 'gray')  # front
        ]
        # buggy wheels
        r = 20  # radius
        d = 2*r # diameter
        @active_spoke = 0
        @wheels = Array.new(2) do |i|
            Circle.new(x: x+r+i*(w-d), y: @y0+h+r, radius: r, color: 'brown')
        end
        @spokes_lt = [
            Triangle.new(x1: x+r, y1: @y0+h+r, x2: x+r, y2: @y0+h,   x3: x+d, y3: @y0+h+r, color: 'orange'), # top right
            Triangle.new(x1: x+r, y1: @y0+h+r, x2: x+d, y2: @y0+h+r, x3: x+r, y3: @y0+h+d, color: 'orange'), # bottom right
            Triangle.new(x1: x+r, y1: @y0+h+r, x2: x+r, y2: @y0+h+d, x3: x,   y3: @y0+h+r, color: 'orange'), # bottom left
            Triangle.new(x1: x+r, y1: @y0+h+r, x2: x,   y2: @y0+h+r, x3: x+r, y3: @y0+h,   color: 'orange')  # top left
        ]
        @spokes_rt = @spokes_lt.map do |spoke_lt|
            spoke_rt = spoke_lt.dup if spoke_lt.remove
            spoke_rt.x1 += w-d; spoke_rt.x2 += w-d; spoke_rt.x3 += w-d;
            spoke_rt
        end
    end

    def contained_by?(shape)
        shape.contains?(@body_sides[1].x3, @body_sides[1].y3) ||
        shape.contains?(@body_sides[1].x2, @body_sides[1].y2) ||
        @wheels.any? { |wheel| shape.contains? wheel.x, wheel.y }
    end

    def jumping?
        !@vy.zero? || @body_floor.y < @y0
    end

    def jump
        @vy -= 23
    end

    def move(rotate_wheel)
        move_spoke if rotate_wheel
        return unless jumping?
        @body_floor.y += @vy
        @body_sides.each { |side| side.y1 += @vy; side.y2 += @vy; side.y3 += @vy; }
        @wheels.each { |wheel| wheel.y += @vy }
        @spokes_lt.each { |spoke| spoke.y1 += @vy; spoke.y2 += @vy; spoke.y3 += @vy; }
        @spokes_rt.each { |spoke| spoke.y1 += @vy; spoke.y2 += @vy; spoke.y3 += @vy; }
        @body_floor.y == @y0 ? @vy = 0 : @vy += 0.5
    end

    def move_spoke
        @spokes_lt[@active_spoke].remove
        @spokes_rt[@active_spoke].remove
        @active_spoke += 1
        @active_spoke = 0 if @active_spoke >= @spokes_lt.length
        @spokes_lt[@active_spoke].add
        @spokes_rt[@active_spoke].add
    end
end
