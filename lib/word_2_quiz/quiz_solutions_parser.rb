require "yomu"
require "docx"
require "strscan"
require "word_2_quiz/quiz"
require "word_2_quiz/helpers"
require "byebug"
module Word2Quiz
  def self.parse_answers(file_path)
    yomu = Yomu.new file_path
    text = yomu.text
    scanner = StringScanner.new(text)
    answers = {}
    while !scanner.eos? do
      question_answer = scanner.scan(/\d+\.\s\s[A-Z]/)
      byebug
      answer_data = question_answer.split(".")
      # First is the question number, Second is the letter answer
      answers[answer_data[0]] = answer_data[1]
    end
    byebug
    answers
  end

end
