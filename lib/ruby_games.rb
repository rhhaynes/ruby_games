require "ruby2d"
require "ruby_games/cli"
require "ruby_games/version"

module RubyGames
    module RubyBrickBreaker
        require "ruby_games/ruby_brick_breaker/ball"
        require "ruby_games/ruby_brick_breaker/brick"
        require "ruby_games/ruby_brick_breaker/game"
        require "ruby_games/ruby_brick_breaker/paddle"
    end
    module RubySnake
        require "ruby_games/ruby_snake/food"
        require "ruby_games/ruby_snake/game"
        require "ruby_games/ruby_snake/obstacle"
        require "ruby_games/ruby_snake/snake"
    end
    module RubySpaceship
        require "ruby_games/ruby_spaceship/alien"
        require "ruby_games/ruby_spaceship/game"
        require "ruby_games/ruby_spaceship/laser"
        require "ruby_games/ruby_spaceship/obstacle"
        require "ruby_games/ruby_spaceship/spaceship"
    end
end
RubyGames::WINDOW = get :window
