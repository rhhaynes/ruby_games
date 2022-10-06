class RubyGames::SpaceBlaster::Game
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
            add_obstacles if @tick % 60 == 0
            add_alien if @tick % 120 == 0
            move_lasers
            move_aliens
            move_obstacles
            reset if collision?
        end
    end

    private

    def add_alien
        @aliens << RubyGames::SpaceBlaster::Alien.new(@max_x, @spaceship.nose[:y], @speed)
    end

    def add_obstacles(n = [1,2,3].sample)
        props = { x_min: @max_x, x_max: @max_x+150, y_min: 0, y_max: @max_y-150 }
        invalid = -> (obstacle) { false }
        @obstacles.concat(RubyGames::SpaceBlaster::Obstacle.create(n, @speed, props, invalid))
    end

    def collision?
        @spaceship.tail[:x]     <= 0 || @spaceship.nose[:x]     >= @max_x ||
        @spaceship.tail[:y_min] <= 0 || @spaceship.tail[:y_max] >= @max_y ||
        @aliens.any? { |alien| @spaceship.contains? alien.x, alien.y } ||
        @obstacles.any? { |obstacle| @spaceship.contained_by? obstacle }
    end

    def create_obstacles(n = 5)
        props = { x_min: 150, x_max: @max_x-150, y_min: 0, y_max: @max_y-150 }
        invalid = -> (obstacle) { @spaceship.contained_by? obstacle }
        @obstacles = RubyGames::SpaceBlaster::Obstacle.create(n, @speed, props, invalid)
    end

    def handle_key_down(key)
        case key
        when /shift/  then @paused = !@paused
        when 'escape' then @cli.menu
        when 'return' then reset
        when 'space'  then @lasers << @spaceship.fire_laser
        end
    end

    def handle_key_held(key)
        case key
        when 'up','down','left','right' then @spaceship.move(key) unless @paused
        end
    end

    def move_aliens
        @aliens.each { |alien| alien.move( @spaceship.nose[:y] <=> alien.y ) }
        @aliens.reject! { |alien| alien.remove if alien.x.negative? }
    end

    def move_lasers
        alien_del_map = {}
        laser_del_map = {}
        @lasers.each_with_index do |laser, i_laser|
            laser.move
            i_alien = @aliens.index { |alien| alien.contains? laser.beam.x2, laser.beam.y2 }
            if i_alien
                alien_del_map[i_alien] = true
                laser_del_map[i_laser] = true
            end
        end
        @lasers.reject!.with_index do |laser, i|
            laser.remove if laser_del_map[i] || laser.beam.x1 > @max_x ||
            @obstacles.any? { |obstacle| obstacle.contains? laser.beam.x2, laser.beam.y2 }
        end
        @aliens.reject!.with_index do |alien, i|
            alien.remove if alien_del_map[i]
        end
    end

    def move_obstacles
        @obstacles.each { |obstacle| obstacle.move }
        @obstacles.reject! { |obstacle| (obstacle.x+150).negative? }
    end

    def reset
        @window.clear
        @tick = 0
        @paused = true
        @speed = 5
        @spaceship = RubyGames::SpaceBlaster::Spaceship.new(@max_y/2, @speed)
        @aliens = []
        @lasers = []
        create_obstacles
    end
end
