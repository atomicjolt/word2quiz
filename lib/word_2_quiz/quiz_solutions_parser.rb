require "yomu"
require "docx"
require "strscan"

module Word2Quiz
  def self.parse_answers(file_path)
    yomu = Yomu.new file_path
    text = yomu.text

    scanner = StringScanner.new(text)
    answers = {}

    while scanner.scan_until(/\d+\.\s+[A-Z]/) && !scanner.eos?
      solution_text = scanner.matched.split(".").map(&:strip)
      question_answer = [solution_text].to_h
      answers.merge!(question_answer)
    end

    answers
  end
end
