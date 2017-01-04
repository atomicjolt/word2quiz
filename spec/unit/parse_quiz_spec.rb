require "rspec"
require "rspec/mocks"
require "word_2_quiz/quiz_parser"
require "word_2_quiz/quiz"

describe Word2Quiz do
  describe "quiz_parser" do
    before do
      fake_doc = double(paragraphs: [])
      fake_quiz = Word2Quiz::Quiz.new(description: "", title: "", time_limit: 0)

      allow(Docx::Document).to receive(:open).and_return(fake_doc)
      allow(Word2Quiz::Quiz).to receive(:from_paragraphs).and_return(fake_quiz)
    end

    it "returns a quiz" do
      expect(Word2Quiz.parse_quiz("file/path.docx")).to be_a Word2Quiz::Quiz
    end

    it "should parse the document" do
      expect(Docx::Document).to receive(:open).with("file/path.docx")
      Word2Quiz.parse_quiz("file/path.docx")
    end

    it "should create a quiz from the paragraphs" do
      expect(Word2Quiz::Quiz).to receive(:from_paragraphs)
      Word2Quiz.parse_quiz("file/path.docx")
    end
  end
end
