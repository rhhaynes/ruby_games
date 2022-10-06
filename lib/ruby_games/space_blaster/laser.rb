class RubyGames::SpaceBlaster::Laser
    attr_reader :beam

    def initialize(x, y, speed, color = 'red')
        @vx = speed
        @beam = Line.new(
            x1: x-5, y1: y,
            x2: x+5, y2: y,
            width: 4, color: color
        )
    end

    def move
        @beam.x1 += @vx
        @beam.x2 += @vx
    end

    def remove
        @beam.remove
    end
end
