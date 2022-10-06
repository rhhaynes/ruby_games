class RubyGames::BrickBreaker::Brick
    def initialize(x, y, color = 'red')
        @rectangle = Rectangle.new(x: x, y: y, width: 50, height: 10, color: color)
    end

    def self.create(props)
        bricks = []
        x_vals = props[:x_min].step(props[:x_max], 60).to_a
        y_vals = props[:y_min].step(props[:y_max], 20).to_a
        x_vals.each do |x|
            y_vals.each do |y|
                bricks << new(x, y)
            end
        end
        bricks
    end

    def contains?(x, y)
        @rectangle.contains? x, y
    end

    def remove
        @rectangle.remove
    end
end
