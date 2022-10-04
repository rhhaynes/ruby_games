class RubyGames::RubySnake::Obstacle
    def initialize(x, y, size, color = 'blue')
        @square = Square.new(x: x, y: y, size: size, color: color)
    end

    def self.create(n, props, invalid)
        obstacles = []
        x = props[:x_min].step(props[:x_max], 10).to_a
        y = props[:y_min].step(props[:y_max], 10).to_a
        size = 50.step(150, 10).to_a
        n.times do
            obstacle = new(x.sample, y.sample, size.sample)
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

    def remove
        @square.remove
    end
end
