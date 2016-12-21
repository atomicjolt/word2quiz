require "word_2_quiz/question"
require "word_2_quiz/answer"

module Word2Quiz
  class Quiz
    attr_accessor :questions, :description

    def initialize
      @questions = []
      @description = ""
    end
  end
end
