class RubyGames::SpaceBlaster::Obstacle
    def initialize(x, y, size, speed, color = 'blue')
        @vx = -speed
        @square = Square.new(x: x, y: y, size: size, color: color)
    end

    def self.create(n, speed, props, invalid)
        obstacles = []
        x = props[:x_min].step(props[:x_max], 10).to_a
        y = props[:y_min].step(props[:y_max], 10).to_a
        size = 50.step(150, 10).to_a
        n.times do
            obstacle = new(x.sample, y.sample, size.sample, speed)
            if invalid.(obstacle)
                obstacle.remove
                redo
            end
            obstacles << obstacle
        end
        obstacles
    end

    def contains?(x, y)
        @square.contains? x, y
    end

    def move
        @square.x += @vx
    end

    def remove
        @square.remove
    end

    def x
        @square.x
    end

    def y
        @square.y
    end
end
