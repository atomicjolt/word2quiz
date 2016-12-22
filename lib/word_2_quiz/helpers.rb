require "numbers_in_words"
module Word2Quiz
  module Helpers
    ##
    # Takes in an array of indexes, and spits out an array of arrays of lines
    # bounded by the indexes.
    def self.map_to_boundaries(indexes:, paragraphs:)
      indexes.map.with_index do |start_index, i|
        first_index = start_index
        last_index = indexes[i+1] || paragraphs.count

        paragraphs[first_index...last_index]
      end
    end

    def self.get_quiz_duration(paragraphs)
      time_paragraph = paragraphs.find do |p|
        p.text.include?("This examination consists of one session not to exceed ")
      end

      time = time_paragraph.text.sub(
        "This examination consists of one session not to exceed ",
        ""
      ).chomp(".")

      time_number = time.split(" ")[0]
      time_unit = time.split(" ")[1]
      unit_conversion = TIME_TO_MINUTES_MAP[time_unit]
      quiz_duration = NumbersInWords.in_numbers(time_number) * unit_conversion
    end

    def self.get_quiz_title(paragraphs)
      paragraphs[3..4].map(&:text).join(" ")
    end

    def self.get_quiz_description(paragraphs)
      paragraphs[0..5].map(&:to_html).join("\n")
    end
  end
end
