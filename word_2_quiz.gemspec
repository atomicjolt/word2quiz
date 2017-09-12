# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "word_2_quiz/version"

Gem::Specification.new do |spec|
  spec.name          = "word_2_quiz"
  spec.version       = Word2Quiz::VERSION
  spec.authors       = ["Atomic Jolt"]

  spec.summary       = "Read in word doc quizzes and return a hash of questions with answers"
  spec.description   = "Read in word doc quizzes and return a hash of questions with answers"
  spec.homepage      = "https://github.com/atomicjolt/word2quiz"

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
    ["doc_ripper", "~> 0.0.7.2"],
    ["docx", "~> 0.2"],
    ["numbers_in_words", "~> 0.4"],
    ["activesupport", "> 4.2"],
  ].each { |d| spec.add_runtime_dependency(*d) }
end
