
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ruby_games/version"

Gem::Specification.new do |spec|
    spec.name          = "ruby_games"
    spec.version       = RubyGames::VERSION
    spec.authors       = ["R. Harris Haynes"]
    spec.email         = ["harrishaynes@gmail.com"]

    spec.summary       = "Terminal games written in Ruby."
    spec.homepage      = "https://github.com/rhhaynes/ruby_games"
    spec.license       = "MIT"

    spec.files         = `git ls-files -z`.split("\x0").reject do |f|
        f.match(%r{^(test|spec|features)/})
    end
    spec.bindir        = "exe"
    spec.executables   = ["ruby_games"]
    spec.require_paths = ["lib"]

    spec.add_development_dependency "bundler"
    spec.add_development_dependency "rake"
    spec.add_runtime_dependency "ruby2d"
end
