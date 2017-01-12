require "word_2_quiz/question"
require "word_2_quiz/answer"
require "word_2_quiz/helpers"

module Word2Quiz
  ##
  # Quiz contains all quiz data. A quiz has a description,
  # a title, a time limit, and questions.
  ##
  class Quiz
    attr_accessor :questions, :description, :title, :time_limit

    ALLOWED_ATTEMPTS = 1

    def initialize(title:, time_limit:, description: "")
      @questions = []
      @description = description
      @title = title
      @time_limit = time_limit
    end

    def self.from_paragraphs(paragraphs, answers)
      all_question_paragraphs = Quiz.get_question_paragraphs(paragraphs)

      quiz_title = Helpers.get_quiz_title(paragraphs)
      quiz_description = Helpers.get_quiz_description(paragraphs)

      quiz_duration = Helpers.get_quiz_duration(paragraphs)

      quiz = Quiz.new(
        title: quiz_title,
        time_limit: quiz_duration,
        description: quiz_description,
      )

      all_question_paragraphs.each do |question_paragraphs|
        question_number = Helpers.get_question_number(question_paragraphs)
        question = Question.from_paragraphs(
          question_paragraphs,
          answers[question_number],
        )

        quiz.questions.push(question)
      end
      quiz
    end

    def self.get_question_paragraphs(paragraphs)
      question_start_index = Helpers.get_question_start_index(paragraphs)
      question_end_index = Helpers.get_question_end_index(paragraphs)

      question_range = paragraphs[question_start_index...question_end_index]

      question_indexes = Helpers.get_question_indexes(question_range)

      Helpers.map_to_boundaries(
        indexes: question_indexes,
        paragraphs: question_range,
      )
    end

    def to_h
      {
        title: @title,
        questions: @questions.map(&:to_h),
        description: @description,
        time_limit: @time_limit,
      }
    end

    def to_canvas
      {
        title: @title,
        question_count: @questions.count,
        points_possible: @questions.count * Question::POINTS_POSSIBLE,
        quiz_type: "assignment",
        description: @description,
        allowed_attempts: ALLOWED_ATTEMPTS,
        time_limit: @time_limit,
      }
    end

    def questions_as_canvas
      @questions.map(&:to_canvas)
    end
  end
end
