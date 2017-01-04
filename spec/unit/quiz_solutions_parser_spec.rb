require "word_2_quiz/quiz_solutions_parser"
require "rspec"
require "rubygems"

describe Word2Quiz do
  describe "parse_answers " do
    before do
      allow(Yomu).to receive(:new).and_return(
        double(text: "Quiz solutions: 1. A  2. B"),
      )
    end

    it "opens the document" do
      expect(Yomu).to receive(:new).and_return(
        double(text: "Quiz solutions: 1. A  2. B"),
      )

      Word2Quiz.parse_answers("file path")
    end

    it "parses the answers" do
      answers = Word2Quiz.parse_answers("file path")
      expect(answers["1"]).to eq "A"
      expect(answers["2"]).to eq "B"
    end
  end
end
