class RubyGames::Snake::Food
    def initialize(x, y, color = 'red')
        @circle = Circle.new(x: x, y: y, radius: 5, color: color)
    end

    def self.create(n, props, invalid)
        foods = []
        x = props[:x_min].step(props[:x_max], 10).to_a
        y = props[:y_min].step(props[:y_max], 10).to_a
        n.times do
            food = new(x.sample, y.sample)
            if invalid.(food)
                food.remove
                redo
            end
            foods << food
        end
        foods
    end

    def contains?(x, y)
        @circle.contains? x, y
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
