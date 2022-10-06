class RubyGames::RubyBrickBreaker::Paddle
    attr_reader :segments

    def initialize(max_x, max_y, speed, color = 'lime')
        @max_x = max_x
        @max_y = max_y
        @speed = speed
        @width = 120
        @height = 15
        x = @max_x/2-@width/2
        y = @max_y-@height-5
        @segments = Array.new(8) do |i|
            Rectangle.new(x: x+i*15, y: y, width: @height, height: @height, color: color)
        end
    end

    def contains?(x, y)
        @segments.any? { |rect| rect.contains? x, y }
    end

    def move(key)
        case key
        when 'left'
            dx = @segments[0].x
            vx = dx > @speed ? -@speed : -dx
        when 'right'
            dx = @max_x-@segments[-1].x-15
            vx = dx > @speed ? @speed : dx
        end
        @segments.each { |rect| rect.x += vx }
    end
end
