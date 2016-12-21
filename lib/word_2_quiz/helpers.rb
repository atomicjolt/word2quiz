module Word2Quiz
  module Helpers
    ##
    # Takes in an array of indexes, and spits out an array of arrays of lines
    # bounded by the indexes.
    def self.map_to_boundaries(indexes, lines)
      indexes.map.with_index do |start_index, i|
        first_index = start_index
        last_index = indexes[i+1] || lines.count

        lines[first_index...last_index]
      end
    end
  end
end
