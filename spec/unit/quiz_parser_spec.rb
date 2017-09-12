require "rspec"
require "rspec/mocks"
require "word_2_quiz/quiz_parser"
require "word_2_quiz/quiz"
require "factory_girl"

describe Word2Quiz do
  describe "quiz_parser" do
    before do
      @valid_fake_doc = double(
        paragraphs: [],
        text: "Course Examination Multiple Choice",
      )

      @invalid_fake_doc = double(
        paragraphs: [],
        text: "",
      )

      fake_quiz = Word2Quiz::Quiz.new(description: "", title: "", time_limit: 0)

      allow(Docx::Document).to receive(:open).and_return(@valid_fake_doc)
      allow(Word2Quiz::Quiz).to receive(:from_paragraphs).and_return(fake_quiz)
      allow(Word2Quiz).to receive(:parse_answers)
    end

    it "returns a quiz" do
      expect(Word2Quiz.parse_quiz("file/path.docx", "file/path.docx")).
        to be_a Word2Quiz::Quiz
    end

    it "should parse the document" do
      expect(Docx::Document).to receive(:open).with("file/path.docx")
      Word2Quiz.parse_quiz("file/path.docx", "file/path.docx")
    end

    it "should get the answer key" do
      expect(Word2Quiz).to receive(:parse_answers)
      Word2Quiz.parse_quiz("file/path.docx", "file/path.docx")
    end

    it "should create a quiz from the paragraphs" do
      expect(Word2Quiz::Quiz).to receive(:from_paragraphs)
      Word2Quiz.parse_quiz("file/path.docx", "file/path.docx")
    end

    it "should raise an error when the document is invalid" do
      allow(Docx::Document).to receive(:open).and_return(@invalid_fake_doc)
      expect do
        Word2Quiz.parse_quiz("file/path.docx", "file/path.docx")
      end.to raise_error(Word2Quiz::InvalidQuiz)
    end
  end
end
