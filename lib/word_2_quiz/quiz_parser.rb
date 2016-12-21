require "yomu"
require "docx"
require "word_2_quiz/quiz"
require "word_2_quiz/helpers"

module Word2Quiz
  def self.parse_quiz(file_path)
    doc = Docx::Document.open(file_path)
    paragraphs = doc.paragraphs
    question_start_indexes = doc.paragraphs.each_index.select do |i|
      paragraphs[i].text.match(/^\d*\./)
    end

    all_question_paragraphs = Helpers.map_to_boundaries(
      question_start_indexes,
      paragraphs
    )

    quiz = Quiz.new

    all_question_paragraphs.each do |question_paragraphs|
      question = Question.from_paragraphs(question_paragraphs, "")

      quiz.questions.push(question)
    end
  end
end
