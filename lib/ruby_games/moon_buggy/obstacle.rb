class RubyGames::MoonBuggy::Obstacle
    def initialize(x, y, size, speed, color = 'blue')
        @vx = -speed
        @square = Square.new(x: x, y: y, size: size, color: color)
    end

    def self.create(n, speed, props)
        obstacles = []
        x = props[:x_min].step(props[:x_max], 10).to_a
        y = props[:y_min].step(props[:y_max], 10).to_a
        size = 50.step(50, 10).to_a
        n.times { obstacles << new(x.sample, y.sample, size.sample, speed) }
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
