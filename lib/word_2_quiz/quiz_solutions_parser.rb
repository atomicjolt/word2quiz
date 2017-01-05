require "yomu"
require "docx"
require "strscan"

module Word2Quiz
  def self.parse_answers(file_path)
    yomu = Yomu.new file_path
    text = yomu.text

    scanner = StringScanner.new(text)
    answers = {}

    while scanner.scan_until(/\d+\.\s+[A-Z]/)
      solution_text = scanner.matched.split(".").map(&:strip)
      answers.merge!([solution_text].to_h)
    end

    answers
  end
end
