require "ruby2d"
require "ruby_games/cli"
require "ruby_games/version"

module RubyGames
    module BrickBreaker
        require "ruby_games/brick_breaker/ball"
        require "ruby_games/brick_breaker/brick"
        require "ruby_games/brick_breaker/game"
        require "ruby_games/brick_breaker/paddle"
    end
    module MoonBuggy
        require "ruby_games/moon_buggy/buggy"
        require "ruby_games/moon_buggy/game"
        require "ruby_games/moon_buggy/obstacle"
    end
    module Snake
        require "ruby_games/snake/food"
        require "ruby_games/snake/game"
        require "ruby_games/snake/obstacle"
        require "ruby_games/snake/snake"
    end
    module SpaceBlaster
        require "ruby_games/space_blaster/alien"
        require "ruby_games/space_blaster/game"
        require "ruby_games/space_blaster/laser"
        require "ruby_games/space_blaster/obstacle"
        require "ruby_games/space_blaster/spaceship"
    end
end
RubyGames::WINDOW = get :window
