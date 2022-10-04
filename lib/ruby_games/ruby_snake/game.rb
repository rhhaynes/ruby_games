class RubyGames::RubySnake::Game
    def initialize(cli)
        @cli = cli
        @cli.handle_key_down = -> (key) { handle_key_down(key) }
        @window = @cli.window
        @max_x = @window.get :width
        @max_y = @window.get :height
    end

    def start
        reset
        @cli.update = -> () do
            @tick += 1
            next if @paused || @tick % 2 != 0
            @snake.update
            @snake.grow if eating?
            reset if collision? || @snake.collision? || @food.empty?
        end
    end

    private

    def collision?
        head = @snake.head
        head.x <= 0 || head.y <= 0 || head.x >= @max_x || head.y >= @max_y ||
        @obstacles.any? { |obstacle| obstacle.contains? head.x, head.y }
    end

    def create_food(n)
        props = { x_min: 10, x_max: @max_x-10, y_min: 10, y_max: @max_y-10 }
        invalid = -> (food) { @snake.contained_by?(food) || @obstacles.any? { |obstacle| obstacle.contains? food.x, food.y }}
        @food = RubyGames::RubySnake::Food.create(n, props, invalid)
    end

    def create_obstacles(n)
        props = { x_min: 10, x_max: @max_x-150, y_min: 10, y_max: @max_y-150 }
        invalid = -> (obstacle) { @snake.contained_by? obstacle }
        @obstacles = RubyGames::RubySnake::Obstacle.create(n, props, invalid)
    end

    def eating?
        head = @snake.head
        index = @food.index { |food| food.contains? head.x, head.y }
        index ? @food.delete_at(index).remove : false
    end

    def handle_key_down(key)
        case key
        when /shift/  then @paused = !@paused
        when 'escape' then @cli.menu
        when 'return' then reset
        when 'up','down','left','right' then @snake.set_direction(key) unless @paused
        end
    end

    def reset
        @window.clear
        @tick = 0
        @paused = true
        @snake = RubyGames::RubySnake::Snake.new(@max_y/2, 25)
        create_obstacles(20)
        create_food(8)
    end
end
