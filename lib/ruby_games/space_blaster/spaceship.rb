class RubyGames::SpaceBlaster::Spaceship
    def initialize(y, speed, color = 'lime')
        @speed = speed
        @body = Triangle.new(
            x1: 30, y1: y-10,
            x2: 30, y2: y+10,
            x3: 50, y3: y,
            color: color
        )
    end

    def contained_by?(shape)
        shape.contains?(@body.x1, @body.y1) ||
        shape.contains?(@body.x2, @body.y2) ||
        shape.contains?(@body.x3, @body.y3)
    end

    def contains?(x, y)
        @body.contains? x, y
    end

    def fire_laser
        RubyGames::SpaceBlaster::Laser.new(@body.x3, @body.y3, 2*@speed)
    end

    def move(key)
        case key
        when 'up'    then @body.y1 -= @speed; @body.y2 -= @speed; @body.y3 -= @speed;
        when 'down'  then @body.y1 += @speed; @body.y2 += @speed; @body.y3 += @speed;
        when 'left'  then @body.x1 -= @speed; @body.x2 -= @speed; @body.x3 -= @speed;
        when 'right' then @body.x1 += @speed; @body.x2 += @speed; @body.x3 += @speed;
        end
    end

    def nose
        { x: @body.x3, y: @body.y3 }
    end

    def tail
        { x: @body.x1, y_min: @body.y1, y_max: @body.y2 }
    end
end
