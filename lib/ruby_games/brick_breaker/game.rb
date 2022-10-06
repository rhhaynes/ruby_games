class RubyGames::BrickBreaker::Game
    def initialize(cli)
        @cli = cli
        @cli.handle_key_down = -> (key) { handle_key_down(key) }
        @cli.handle_key_held = -> (key) { handle_key_held(key) }
        @window = @cli.window
        @max_x = @window.get :width
        @max_y = @window.get :height
    end

    def start
        reset
        @cli.update = -> () do
            @tick += 1
            next if @paused
            move_ball
            reset if collision_bottom? || @bricks.empty?
        end
    end

    private

    def collision_bottom?
        @ball.y >= @max_y
    end

    def collision_brick?
        index = @bricks.index { |brick| @ball.contained_by? brick }
        @bricks.delete_at(index).remove if index
    end

    def collision_paddle?
        @ball.contained_by? @paddle
    end

    def collision_side?
        @ball.x <= 0 || @ball.x >= @max_x
    end

    def collision_top?
        @ball.y <= 0
    end

    def create_bricks
        props = { x_min: 5, x_max: @max_x-30, y_min: 5, y_max: 105 }
        @bricks = RubyGames::BrickBreaker::Brick.create(props)
    end

    def handle_key_down(key)
        case key
        when /shift/  then @paused = !@paused
        when 'escape' then @cli.menu
        when 'return' then reset
        end
    end

    def handle_key_held(key)
        case key
        when 'left','right' then @paddle.move(key) unless @paused
        end
    end

    def move_ball
        if collision_paddle?
            @vy *= -1
            index = @paddle.segments.index { |rect| rect.contains? @ball.x, @ball.y }
            case index
            when 0,7 then x_term = 4
            when 1,6 then x_term = 2
            when 2,5 then x_term = 1
            when 3,4 then x_term = 0
            end
            x_term *= -1 if [0,1,2].include? index
            @vx += x_term
            if @vx == 0
                @vx =  1 if @ball.x <= 0
                @vx = -1 if @ball.x >= @max_x
            else
                @vx =  2*@speed if @vx >  2*@speed
                @vx = -2*@speed if @vx < -2*@speed
            end
        else
            @vx *= -1 if collision_side?
            @vy *= -1 if collision_top? || collision_brick?
        end
        @ball.move(@vx, @vy)
    end

    def reset
        @window.clear
        @tick = 0
        @paused = true
        @speed = 8
        @vx =  @speed/4
        @vy = -@speed
        @ball = RubyGames::BrickBreaker::Ball.new(@max_x/2, @max_y-25)
        @paddle = RubyGames::BrickBreaker::Paddle.new(@max_x, @max_y, 12)
        create_bricks
    end
end
