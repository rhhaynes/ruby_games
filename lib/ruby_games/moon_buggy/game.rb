class RubyGames::MoonBuggy::Game
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
            next if @paused
            add_obstacles if @tick % 120 == 0
            move_buggy
            move_obstacles
            reset if collision?
        end
    end

    private

    def add_obstacles(n = [1,2,3].sample)
        props = { x_min: @max_x, x_max: @max_x, y_min: @max_y/2, y_max: @max_y-50 }
        @obstacles.concat(RubyGames::MoonBuggy::Obstacle.create(n, @speed, props))
    end

    def collision?
        @obstacles.any? { |obstacle| @buggy.contained_by? obstacle }
    end

    def handle_key_down(key)
        case key
        when /shift/  then @paused = !@paused
        when 'escape' then @cli.menu
        when 'return' then reset
        when 'space'  then @buggy.jump unless @buggy.jumping?
        end
    end

    def move_buggy
        rotate_wheel = @tick % 6 == 0
        @buggy.move(rotate_wheel)
    end

    def move_obstacles
        @obstacles.each { |obstacle| obstacle.move }
        @obstacles.reject! { |obstacle| obstacle.remove if (obstacle.x+50).negative? }
    end

    def reset
        @window.clear
        @tick = 0
        @paused = true
        @speed = 8
        @buggy = RubyGames::MoonBuggy::Buggy.new(@max_x/4, @max_y-55)
        @obstacles = []
    end
end
