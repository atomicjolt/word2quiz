module Word2Quiz
  class Answer
    attr_accessor :text, :correct

    def initialize(text = "", correct = false)
      @text = text
      @correct = correct
    end

    def self.from_lines(lines, solution)
      text = "#{lines[0].sub(/^[a-z]\./, '')}\n" +
             "#{lines[1...lines.count].join("\n")}"

      is_correct = lines[0].match(/^[a-z]/)[0] == solution
      Answer.new(text, is_correct)
    end
  end
end
