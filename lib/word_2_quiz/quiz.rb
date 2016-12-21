require "word_2_quiz/question"
require "word_2_quiz/answer"

module Word2Quiz
  class Quiz
    attr_accessor :questions, :description, :title

    def initialize
      @questions = []
      @description = ""
      @title = ""
    end

    def to_h
      {
        questions: @questions.map(&:to_h),
        description: @descriptions
      }
    end

    def to_canvas
      {
        title: @title,
        question_count: @questions.count,
        quiz_type: "assignment",
        description: @description,
        allowed_attempts: 1,

      }
    end
  end
end
