require "docx"
require "byebug"
require "word_2_quiz/quiz"
require "word_2_quiz/helpers"

TIME_TO_MINUTES_MAP = {
  "hours" => 60,
  "minutes" => 1
}

module Word2Quiz
  def self.parse_quiz(file_path)
    doc = Docx::Document.open(file_path)
    paragraphs = doc.paragraphs

    question_start_indexes = paragraphs.each_index.select do |i|
      paragraphs[i].text.match(/^\d*\./)
    end

    quiz_end_index = paragraphs.find_index do |i|
      i.text.include?("End of examination")
    end

    all_question_paragraphs = Helpers.map_to_boundaries(
      indexes: question_start_indexes,
      paragraphs: paragraphs[0...quiz_end_index]
    )

    quiz_title = Helpers.get_quiz_title(paragraphs)
    quiz_description = Helpers.get_quiz_description(paragraphs)

    quiz_duration = Helpers.get_quiz_duration(paragraphs)

    quiz = Quiz.new(
      title: quiz_title,
      time_limit: quiz_duration,
      description: quiz_description
    )

    all_question_paragraphs.each do |question_paragraphs|
      question = Question.from_paragraphs(question_paragraphs, "")

      quiz.questions.push(question)
    end

    quiz
  end
end
