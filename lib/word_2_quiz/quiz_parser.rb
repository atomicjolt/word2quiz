require "byebug"
require "yomu"
require "word_2_quiz/quiz"

module Word2Quiz
  def self.parse_quiz(file_path)
    yomu_quiz = Yomu.new file_path
    quiz_text = yomu_quiz.text
    question_text = quiz_text.match(/Multiple Choice.*/m)[0]
    lines = question_text.lines.map(&:chomp)

    question_start_indexes = lines.each_index.select do |i|
      # a question starts with a number and a dot
      lines[i].match(/^\d*\./)
    end

    all_question_lines = question_start_indexes.map.with_index do |index, i|
      first_index = index
      last_index = question_start_indexes[i+1] || lines.count

      lines[first_index...last_index]
    end

    byebug

    quiz = Quiz.new

    all_question_lines.each do |question_lines|
      question = Question.from_lines(question_lines, "")

      quiz.questions.concat(question)
    end
    byebug
    c = 1
  end
end
