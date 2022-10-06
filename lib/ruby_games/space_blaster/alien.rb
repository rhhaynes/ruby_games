class RubyGames::SpaceBlaster::Alien
    def initialize(x, y, speed)
        @vx = -1.6*speed
        @vy =  0.5*speed
        @circle = Circle.new(x: x, y: y, radius: 10, color: 'yellow')
    end

    def contains?(x, y)
        @circle.contains? x, y
    end

    def move(y_sign)
        @circle.x += @vx
        @circle.y += @vy*y_sign
    end

    def remove
        @circle.remove
    end

    def x
        @circle.x
    end

    def y
        @circle.y
    end
end
