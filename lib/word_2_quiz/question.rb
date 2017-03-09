require "word_2_quiz/helpers"
require "word_2_quiz/errors"

module Word2Quiz
  ##
  # Question contains all data for a single question. A question has text, and
  # answers.
  ##
  class Question
    attr_accessor :text, :answers

    POINTS_POSSIBLE = 5

    def initialize(text = "", answers = [])
      @answers = answers
      @text = text
    end

    ##
    # Creates a question from an array of strings
    # paragraphs: an array of nokogiri nodes containing each line for the
    # question text and answers
    # solution: a string containing which answer(a,b,c,d) is correct
    ##
    def self.from_paragraphs(paragraphs, solution)
      if solution.nil? || solution.empty?
        raise InvalidAnswerKey.new(
          "Question #{Helpers.get_question_number(paragraphs)} does not have" +
          " an answer.",
        )
      end

      answer_start_indexes = paragraphs.each_index.select do |i|
        # an answer starts with a letter then a dot
        paragraphs[i].text.match(/^[a-z]\./)
      end

      all_answer_paragraphs = Helpers.map_to_boundaries(
        indexes: answer_start_indexes,
        paragraphs: paragraphs,
      )

      question_paragraphs = paragraphs.take(answer_start_indexes.first)
      question_paragraphs = Helpers.strip_blanks(question_paragraphs)
      question_text = question_paragraphs.map do |paragraph|
        paragraph.to_html.sub(/(>)\d+\.\s?/, '\1') # Remove question number.
      end.join("\n")

      answers = []

      all_answer_paragraphs.each do |answer_paragraphs|
        answer = Answer.from_paragraphs(answer_paragraphs, solution)
        answers.push(answer)
      end

      Question.new(question_text, answers)
    end

    def to_h
      {
        text: @text,
        answers: @answers.map(&:to_h),
      }
    end

    def to_canvas
      {
        question_type: "multiple_choice_question",
        question_text: @text,
        points_possible: POINTS_POSSIBLE,
        answers: @answers.map(&:to_canvas),
      }
    end
  end
end
