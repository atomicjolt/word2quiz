require "numbers_in_words"
module Word2Quiz
  module Helpers
    TIME_TO_MINUTES_MAP = {
      "hours" => 60,
      "minutes" => 1,
    }.freeze

    # indexes of paragraphs where title and description start and end
    TITLE_START = 3
    TITLE_END = 4
    DESCRIPTION_START = 0
    DESCRIPTION_END = 5

    ##
    # Takes in an array of indexes, and returns out an array of arrays of
    # paragraphs bounded by the indexes, e.g. if indexes is [2, 5] then it
    # returns:
    # [paragraphs[0...2], paragraphs[2...5], paragraphs[5...paragraphs.count]]
    ##
    def self.map_to_boundaries(indexes:, paragraphs:)
      indexes.map.with_index do |start_index, i|
        first_index = start_index
        last_index = indexes[i + 1] || paragraphs.count

        paragraphs[first_index...last_index]
      end
    end

    def self.get_quiz_duration(paragraphs)
      time_paragraph = paragraphs.find do |p|
        p.text.include?("one session not to exceed ")
      end

      time = time_paragraph.text.sub(
        "This examination consists of one session not to exceed ",
        "",
      ).chomp(".")

      time_number = time.split(" ").first
      time_unit = time.split(" ").last
      unit_conversion = TIME_TO_MINUTES_MAP[time_unit]

      NumbersInWords.in_numbers(time_number) * unit_conversion
    end

    ##
    # Returns the quiz title. The 3rd and 4th lines contain the best title for
    # the quiz.
    ##
    def self.get_quiz_title(paragraphs)
      paragraphs[TITLE_START..TITLE_END].map(&:text).join(" ")
    end

    ##
    # Returns the quiz description. Lines 0-5 are the best description for the
    # quiz.
    ##
    def self.get_quiz_description(paragraphs)
      paragraphs[DESCRIPTION_START..DESCRIPTION_END].map(&:to_html).join("\n")
    end

    ##
    # Finds the index of the paragraph where the questions start
    ##
    def self.get_question_start_index(paragraphs)
      paragraphs.find_index { |p| p.text.include?("Multiple Choice") }
    end

    ##
    # Finds the index of the paragraph where the questions end
    ##
    def self.get_question_end_index(paragraphs)
      paragraphs.find_index { |p| p.text.include?("End of examination") }
    end

    ##
    # Returns the indexes of the start of each question.
    ##
    def self.get_question_indexes(paragraphs)
      paragraphs.each_index.select { |i| paragraphs[i].text.match(/^\d*\./) }
    end

    ##
    # Returns an array of paragraphs with leading and trailing blank paragraphs
    # removed.
    ##
    def self.strip_blanks(paragraphs)
      t = paragraphs.drop_while { |p| p.text.chomp.empty? }
      t.pop while t.last.text.chomp.empty?
      t
    end
  end
end
