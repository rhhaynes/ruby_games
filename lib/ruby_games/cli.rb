class RubyGames::CLI
    def initialize
        # window
        @max_x = 1200
        @max_y =  700
        @menu = {
            title: Text.new("Ruby Games", x: @max_x/3, y: 50, size: 64, color: "lime"),
            options: [{
                label: Text.new("Brick Breaker", x: @max_x/6+50, y: 175, size: 42, color: "blue"),
                on_select: -> () { RubyGames::BrickBreaker::Game.new(self).start }
            }, {
                label: Text.new("Moon Buggy", x: @max_x/6+50, y: 250, size: 42, color: "blue"),
                on_select: -> () { RubyGames::MoonBuggy::Game.new(self).start }
            }, {
                label: Text.new("Snake", x: @max_x/6+50, y: 325, size: 42, color: "blue"),
                on_select: -> () { RubyGames::Snake::Game.new(self).start }
            }, {
                label: Text.new("Space Blaster", x: @max_x/6+50, y: 400, size: 42, color: "blue"),
                on_select: -> () { RubyGames::SpaceBlaster::Game.new(self).start }
            }],
            active: {
                index: 0,
                symbol: Text.new(">", x: @max_x/6, y: 175, size: 42, color: "blue")
            }
        }
        @window = RubyGames::WINDOW
        @window.set title: "Ruby Games", width: @max_x, height: @max_y
        # event listeners
        @handle_key_down = -> (key) { handle_key_down(key) }
        @handle_key_held = -> (key) {}
        @window.on :key_down do |event| @handle_key_down.(event.key) end
        @window.on :key_held do |event| @handle_key_held.(event.key) end
        # update loop
        @update = -> () {}
        @window.update { @update.call }
        @window.show
    end

    def menu
        @handle_key_down = -> (key) { handle_key_down(key) }
        @handle_key_held = -> (key) {}
        @update = -> () {}
        @window.clear
        @menu[:title].add
        @menu[:options].each { |option| option[:label].add }
        @menu[:active][:symbol].add
    end

    def handle_key_down=(fn)
        @handle_key_down = fn
    end

    def handle_key_held=(fn)
        @handle_key_held = fn
    end

    def update=(fn)
        @update = fn
    end

    def window
        @window
    end

    private

    def active_option
        @menu[:options][@menu[:active][:index]]
    end

    def handle_key_down(key)
        case key
        when 'escape' then @window.close
        when 'return' then active_option[:on_select].call
        when 'down','right' then
            @menu[:active][:index] += 1
            @menu[:active][:index] = 0 if @menu[:active][:index] > @menu[:options].length-1
            @menu[:active][:symbol].y = active_option[:label].y
        when 'up','left' then
            @menu[:active][:index] -= 1
            @menu[:active][:index] = @menu[:options].length-1 if @menu[:active][:index] < 0
            @menu[:active][:symbol].y = active_option[:label].y
        end
    end
end
