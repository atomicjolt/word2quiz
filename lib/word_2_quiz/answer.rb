module Word2Quiz
  class Answer
    attr_accessor :text, :correct

    def initialize(text = "", correct = false)
      @text = text
      @correct = correct
    end

    def self.from_paragraphs(paragraphs, solution)
      text = paragraphs.map(&:to_html).join("\n")
      answer_letter = paragraphs[0].text.match(/^[a-z]/)
      is_correct = answer_letter && (answer_letter[0] == solution)
      Answer.new(text, is_correct)
    end

    def to_h
      {
        text: @text,
        correct: @correct
      }
    end

    def to_canvas
      {
        answer_text: @text,
        answer_weight: @correct ? 100 : 0
      }
    end
  end
end
