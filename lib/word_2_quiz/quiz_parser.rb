require "docx"
require "byebug"
require "word_2_quiz/quiz"
require "word_2_quiz/helpers"

module Word2Quiz
  def self.parse_quiz(quiz_path, answer_key_path)
    doc = Docx::Document.open(quiz_path)
    paragraphs = doc.paragraphs

    answers = Word2Quiz.parse_answers(answer_key_path)

    Quiz.from_paragraphs(paragraphs, answers)
  end
end
