module Word2Quiz
  class Question
    attr_accessor :text, :answers

    def initialize(text = "", answers = [])
      @answers = answers
      @text = text
    end

    ##
    # Creates a question from an array of strings
    # lines: an array of strings containing each line for the question text and
    #        answers
    # solution: a string containing which answer(a,b,c,d) is correct
    ##
    def self.from_lines(lines, solution)
      answers = []

      answer_start_indexes = lines.each_index.select do |i|
        #an answer starts with a letter then a dot
        lines[i].match(/^[a-z]\./)
      end

      all_answer_lines = answer_start_indexes.map.with_index do |start_index, i|
        first_index = start_index
        last_index = answer_start_indexes[i+1] || lines.count

        lines[first_index...last_index]
      end

      question_text = "#{lines[0].sub(/^\d*\./, "")}\n" +
                      "#{lines[1...answer_start_indexes[0]].join("\n")}"

      answer_start_indexes.each_slice(2) do |answer_indexes|
        start_index = answer_indexes[0]
        end_index = answer_indexes[1] || lines.count

        answer_lines = lines[start_index...end_index]
        answers.concat([Answer.from_lines(answer_lines, solution)])
      end
      byebug
      Question.new(question_text, answers)
    end
  end
end
