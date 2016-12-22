require "word_2_quiz/question"
require "word_2_quiz/answer"

module Word2Quiz
  class Quiz
    attr_accessor :questions, :description, :title, :time_limit

    def initialize(title:, time_limit:, description: "")
      @questions = []
      @description = description
      @title = title
      @time_limit = time_limit
    end

    def to_h
      {
        questions: @questions.map(&:to_h),
        description: @descriptions,
        time_limit: @time_limit
      }
    end

    def to_canvas
      {
        title: @title,
        question_count: @questions.count,
        quiz_type: "assignment",
        description: @description,
        allowed_attempts: 1,
        time_limit: @time_limit
      }
    end
  end
end
