require "ruby2d"
require "ruby_games/cli"
require "ruby_games/version"

module RubyGames
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
