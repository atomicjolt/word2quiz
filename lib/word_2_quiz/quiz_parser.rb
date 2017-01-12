require "docx"
require "word_2_quiz/quiz"
require "word_2_quiz/helpers"
require "word_2_quiz/quiz_solutions_parser"
require "word_2_quiz/errors"

module Word2Quiz
  def self.parse_quiz(quiz_path, answer_key_path)
    doc = Docx::Document.open(quiz_path)
    paragraphs = doc.paragraphs
    text = doc.text

    unless Helpers.valid_quiz?(text)
      raise InvalidQuiz.new("The quiz uploaded is not a valid quiz.")
    end

    answers = Word2Quiz.parse_answers(answer_key_path)

    Quiz.from_paragraphs(paragraphs, answers)
  rescue Zip::Error
    raise InvalidQuiz.new "The quiz was not a docx file."
  end
end
