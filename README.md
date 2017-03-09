# Word2Quiz

Converts word document quizzes to a Word2Quiz::Quiz, which can be converted to a hash or to an Instructure canvas hash format.

## Installation
This gem uses antiword to parse doc files. On a mac:
  `brew install antiword`

On ubuntu:
  `sudo apt-get install antiword`

Add this line to your application's Gemfile:

```ruby
gem 'word_2_quiz'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install word_2_quiz

You will also need to install the [Java Development Kit (JDK)](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html).

## Usage

Expects a docx quiz where every question is on a new line started with a number
followed by a period, and every answer is below each question. Every answer is
on a new line, and begins with a letter followed by a period. The title is
assumed to be on lines 3 & 4, and the description is generated from lines 0-5 of
the quiz.

The answer key should be in a doc file, where each solution consists of a
number and an answer - e.g `1. C  2.B`

To get the parse the quiz, run
  `quiz = Word2Quiz.parse_quiz("path/to/quiz.docx", "path/to/solutions.doc")`

To get the quiz as a hash, run `quiz.to_h`

To get the quiz for creating on canvas run `quiz.to_canvas`

To get the quiz questions for creating on canvas run `quiz.questions_as_canvas`

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/atomicjolt/word2quiz.
