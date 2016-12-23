require "docx"
require "byebug"
require "word_2_quiz/quiz"
require "word_2_quiz/helpers"

module Word2Quiz
  def self.parse_quiz(file_path)
    doc = Docx::Document.open(file_path)
    paragraphs = doc.paragraphs

    Quiz.from_paragraphs(paragraphs)
  end
end
