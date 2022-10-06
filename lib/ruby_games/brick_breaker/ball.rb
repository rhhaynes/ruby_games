class RubyGames::BrickBreaker::Ball
    def initialize(x, y, color = 'white')
        @circle = Circle.new(x: x, y: y, radius: 5, color: color)
    end

    def contained_by?(shape)
        shape.contains? x, y
    end

    def move(vx, vy)
        @circle.x += vx
        @circle.y += vy
    end

    def x
        @circle.x
    end

    def y
        @circle.y
    end
end
