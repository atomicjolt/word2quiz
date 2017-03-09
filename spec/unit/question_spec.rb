require "word_2_quiz/question"
require "rspec"
require "rspec/mocks"
require "rubygems"

describe Word2Quiz::Question do
  before(:each) do
    question = FactoryGirl.create(:doc_question)
    @paragraphs = question.paragraphs

    @answers = FactoryGirl.create_list(:answer, 3)
  end

  describe "from_paragraphs" do
    before(:each) do
      allow(Word2Quiz::Answer).to receive(:from_paragraphs).and_return(
        *@answers,
      )
    end

    it "should raise an error when answer is nil for the question" do
      expect do
        Word2Quiz::Question.from_paragraphs(@paragraphs, nil)
      end.to raise_error(Word2Quiz::InvalidAnswerKey)
    end

    it "should raise an error when answer is empty for the question" do
      expect do
        Word2Quiz::Question.from_paragraphs(@paragraphs, "")
      end.to raise_error(Word2Quiz::InvalidAnswerKey)
    end

    it "should return a new question" do
      question = Word2Quiz::Question.from_paragraphs(@paragraphs, "c")
      expect(question).to be_a(Word2Quiz::Question)
    end

    it "should set answers" do
      question = Word2Quiz::Question.from_paragraphs(@paragraphs, "c")
      expect(question.answers.count).to eq 3
      expect(question.answers).to eq @answers
    end

    it "should set text" do
      question = Word2Quiz::Question.from_paragraphs(@paragraphs, "c")
      expected = @paragraphs[0..1].map(&:to_html).join("\n").sub(/\d+\.\s?/, "")
      expect(question.text).to eq expected
    end
  end

  describe "to_h" do
    before(:each) do
      @question = Word2Quiz::Question.new(@paragraphs[0].to_html, @answers)
      @answers.each do |answer|
        allow(answer).to receive(:to_h).and_return({})
      end
    end

    it "should return a hash" do
      expect(@question.to_h).to be_a(Hash)
    end

    it "should set text" do
      expect(@question.to_h[:text]).to eq @paragraphs[0].to_html
    end

    it "should set answers" do
      @answers.each do |answer|
        expect(answer).to receive(:to_h).and_return({})
      end

      expect(@question.to_h[:answers]).to eq [{}, {}, {}]
    end
  end

  describe "to_canvas" do
    before(:each) do
      @question = Word2Quiz::Question.new(@paragraphs[0].to_html, @answers)
    end

    it "should return a hash" do
      expect(@question.to_canvas).to be_a(Hash)
    end

    it "should set question_text" do
      expect(@question.to_canvas[:question_text]).to eq @paragraphs[0].to_html
    end

    it "should set canvas specific attributes" do
      question_type = @question.to_canvas[:question_type]
      expect(question_type).to eq "multiple_choice_question"
      expect(@question.to_canvas[:points_possible]).to eq 5
    end

    it "should set answers to canvas format answers" do
      expect(@question.to_canvas[:answers]).to eq @answers.map(&:to_canvas)
    end
  end
end
