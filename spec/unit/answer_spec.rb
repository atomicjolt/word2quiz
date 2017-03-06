require "word_2_quiz/answer"
require "rspec"
require "rubygems"

describe Word2Quiz::Answer do
  describe "from_paragraphs" do
    before do
      @paragraphs = []

      @paragraphs << FactoryGirl.create(
        :answer_paragraph,
        text: "a. asdf",
      )
      @paragraphs << FactoryGirl.create(:description_paragraph)

      @correct = "a"
      @incorrect = "b"
    end

    it "should return a new answer" do
      answer = Word2Quiz::Answer.from_paragraphs(@paragraphs, @correct)
      expect(answer).to be_a(Word2Quiz::Answer)
    end

    it "should set correct true when correct" do
      answer = Word2Quiz::Answer.from_paragraphs(@paragraphs, @correct)
      expect(answer.correct).to eq true
    end

    it "should set correct false when incorrect" do
      answer = Word2Quiz::Answer.from_paragraphs(@paragraphs, @incorrect)
      expect(answer.correct).to eq false
    end

    it "should set correct case insensitive" do
      answer = Word2Quiz::Answer.from_paragraphs(@paragraphs, @correct.upcase)
      expect(answer.correct).to eq true
    end

    it "should set text" do
      answer = Word2Quiz::Answer.from_paragraphs(@paragraphs, @correct)
      expected = @paragraphs.map(&:to_html).join("\n").sub(/[a-z]\.\s?/, "")
      expect(answer.text).to eq expected
    end
  end

  describe "to_h" do
    before do
      @answer = Word2Quiz::Answer.new("asdf", true)
    end

    it "should return a hash" do
      expect(@answer.to_h).to be_a(Hash)
    end

    it "should set text" do
      expect(@answer.to_h[:text]).to eq "asdf"
    end

    it "should set correct" do
      expect(@answer.to_h[:correct]).to eq true
    end
  end

  describe "to_canvas" do
    before do
      @answer = Word2Quiz::Answer.new("asdf", true)
    end

    it "should return a hash" do
      expect(@answer.to_canvas).to be_a(Hash)
    end

    it "should set answer_text" do
      expect(@answer.to_canvas[:answer_html]).to eq "asdf"
    end

    it "should set answer_weight when correct" do
      expect(@answer.to_canvas[:answer_weight]).to eq 100
    end

    it "should set answer_weight when incorrect" do
      @answer.correct = false
      expect(@answer.to_canvas[:answer_weight]).to eq 0
    end
  end
end
