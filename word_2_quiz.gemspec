# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "word_2_quiz/version"

Gem::Specification.new do |spec|
  spec.name          = "word_2_quiz"
  spec.version       = Word2Quiz::VERSION
  spec.authors       = ["David Spencer"]
  spec.email         = ["david.spencer@atomicjolt.com"]

  spec.summary       = "Read in word doc quizzes and return a hash of questions with answers"
  spec.description   = "Read in word doc quizzes and return a hash of questions with answers"
  spec.homepage      = "https://github.com"
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "http://mygemserver.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  [
    ["bundler", "~> 1.13"],
    ["rake", "~> 10.0"],
    ["byebug", "~> 9.0"],
    ["rspec", "~> 3.5"],
    ["factory_girl", "~> 4.8"],
  ].each { |d| spec.add_development_dependency(*d) }

  [
    ["yomu", "~> 0.2"],
    ["docx", "~> 0.2"],
    ["numbers_in_words", "~> 0.4"],
    ["activesupport", "~> 4.2"],
  ].each { |d| spec.add_runtime_dependency(*d) }
end
