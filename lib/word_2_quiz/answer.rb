require "word_2_quiz/helpers"

module Word2Quiz
  class Answer
    attr_accessor :text, :correct

    # index of the very first answer paragraph
    ANSWER_START = 0

    # Canvas expects a weight greather than zero for correct, 0 for incorrect.
    CORRECT_WEIGHT = 100
    INCORRECT_WEIGHT = 0

    def initialize(text = "", correct = false)
      @text = text
      @correct = correct
    end

    def self.from_paragraphs(paragraphs, solution)
      non_empty_paragraphs = Helpers.strip_blanks(paragraphs)
      text = non_empty_paragraphs.map(&:to_html).join("\n")
      start_paragraph = non_empty_paragraphs[ANSWER_START]
      is_correct = start_paragraph.text.downcase.start_with?(solution.downcase)

      Answer.new(text, is_correct)
    end

    def to_h
      {
        text: @text,
        correct: @correct,
      }
    end

    def to_canvas
      {
        answer_text: @text,
        answer_weight: @correct ? CORRECT_WEIGHT : INCORRECT_WEIGHT,
      }
    end
  end
end
