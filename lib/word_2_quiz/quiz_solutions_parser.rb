require "doc_ripper"
require "strscan"
require "word_2_quiz/errors"

module Word2Quiz
  def self.parse_answers(file_path)
    text = DocRipper::rip(file_path)

    if text.nil?
      raise InvalidAnswerKey.new "The uploaded answer key could not be parsed."
    end

    answers = {}

    scanner = StringScanner.new(text)

    # Quizzes accidentally uploaded as an answer key don't fail as they match
    # the regex pattern for the answer key in the questions themselves, so we
    # check that the file is actually an answer key by looking for the text that
    # shows up at the top of the columns in the answer key.

    unless text.include?("QUES ANS") && text.include?("---- ---")
      raise InvalidAnswerKey.new "The uploaded answer key is not valid."
    end

    while scanner.scan_until(/\d+\.\s+[A-Z]/)
      solution_text = scanner.matched.split(".").map(&:strip)
      answers.merge!([solution_text].to_h)
    end

    answers
  end
end
