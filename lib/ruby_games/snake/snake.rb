class RubyGames::Snake::Snake
    def initialize(y, length)
        @color = 'lime'
        @direction = 'RT'
        @growing = 0
        @radius = 5
        @diameter = 2*@radius
        @segments = Array.new(length) { |i| new_segment(@diameter*(length-i), y) }
    end

    def collision?
        @segments[3..-1].any? { |segment| head.contains? segment.x, segment.y }
    end

    def contained_by?(shape)
        @segments.any? { |segment| shape.contains? segment.x, segment.y }
    end

    def grow
        @growing += 10
    end

    def growing?
        @growing.positive?
    end

    def head
        @segments[0]
    end

    def new_segment(x, y)
        Circle.new(x: x, y: y, radius: @radius, color: @color)
    end

    def set_direction(key)
        case key
        when 'up'    then @direction = 'UP' unless @direction == 'DN'
        when 'down'  then @direction = 'DN' unless @direction == 'UP'
        when 'left'  then @direction = 'LT' unless @direction == 'RT'
        when 'right' then @direction = 'RT' unless @direction == 'LT'
        end
    end

    def update
        case @direction
        when 'UP' then x = @segments[0].x; y = @segments[0].y-@diameter;
        when 'DN' then x = @segments[0].x; y = @segments[0].y+@diameter;
        when 'RT' then x = @segments[0].x+@diameter; y = @segments[0].y;
        when 'LT' then x = @segments[0].x-@diameter; y = @segments[0].y;
        end
        @segments.unshift(new_segment(x, y))
        @segments.pop.remove unless growing?
        @growing -= 1 if growing?
    end
end
