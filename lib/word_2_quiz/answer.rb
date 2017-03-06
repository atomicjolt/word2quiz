require "word_2_quiz/helpers"

module Word2Quiz
  ##
  # Answer contains all data for a single answer. An answer has text and whether
  # it is correct.
  ##
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

    ##
    # Expects an array of paragraphs that are a single answer, and
    # The correct answer for that question, e.g. answer="a"
    ##
    def self.from_paragraphs(paragraphs, solution)
      non_empty_paragraphs = Helpers.strip_blanks(paragraphs)

      text = non_empty_paragraphs.map do |paragraph|
        paragraph.to_html.sub(/(>)[a-z]\.\s?/i, '\1') # Remove answer letter.
      end.join("\n")

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

    # Canvas has an undocumented answer_html field for answers that we have to
    # use because we are sending html, not plain text.
    def to_canvas
      {
        answer_html: @text,
        answer_weight: @correct ? CORRECT_WEIGHT : INCORRECT_WEIGHT,
      }
    end
  end
end
