require "word_2_quiz/quiz"
require "rspec"
require "rspec/mocks"
require "factory_girl"
require "rubygems"
require "byebug"

RSpec.configure do |config|
  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end

describe Word2Quiz::Quiz do
  before do
    doc = FactoryGirl.create(:doc_quiz)
    @paragraphs = doc.paragraphs

    @questions = FactoryGirl.create_list(:question, 10)
  end

  describe "from_paragraphs" do
    before do
      allow(Word2Quiz::Question).to receive(:from_paragraphs).and_return(
        *@questions,
      )

      @quiz = Word2Quiz::Quiz.from_paragraphs(@paragraphs)
    end

    it "should return a new quiz" do
      expect(@quiz).to be_a(Word2Quiz::Quiz)
    end

    it "should set questions" do
      expect(Word2Quiz::Question).to receive(:from_paragraphs).and_return(
        *@questions,
      )
      quiz = Word2Quiz::Quiz.from_paragraphs(@paragraphs)
      expect(quiz.questions.count).to eq 10
      expect(quiz.questions).to eq @questions
    end

    it "should set description" do
      expected_description = @paragraphs[0..5].map(&:to_html).join("\n")
      expect(@quiz.description).to eq expected_description
    end

    it "should set duration" do
      expect(@quiz.time_limit).to eq 120
    end

    it "should set title" do
      expect(@quiz.title).to eq @paragraphs[3..4].map(&:text).join(" ")
    end
  end

  describe "to_h" do
    before do
      @quiz = Word2Quiz::Quiz.new(
        title: "title",
        time_limit: 120,
        description: "description",
      )

      @quiz.questions = FactoryGirl.create_list(:question, 5)
      @quiz.questions.each do |question|
        allow(question).to receive(:to_h).and_return({})
      end
    end

    it "should return a hash" do
      expect(@quiz.to_h).to be_a(Hash)
    end

    it "should set attributes" do
      expect(@quiz.to_h[:title]).to eq @quiz.title
      expect(@quiz.to_h[:description]).to eq @quiz.description
      expect(@quiz.to_h[:time_limit]).to eq @quiz.time_limit
    end

    it "should set questions" do
      @quiz.questions.each do |question|
        expect(question).to receive(:to_h).and_return({})
      end
      expect(@quiz.to_h[:questions]).to eq (0...5).map { {} }
    end
  end

  describe "to_canvas" do
    before do
      @quiz = Word2Quiz::Quiz.new(
        title: "title",
        time_limit: 120,
        description: "description",
      )

      @quiz.questions = FactoryGirl.create_list(:question, 5)
      @quiz.questions.each do |question|
        allow(question).to receive(:to_h).and_return({})
      end
    end

    it "should return a hash" do
      expect(@quiz.to_h).to be_a(Hash)
    end

    it "should set canvas specific attributes" do
      expect(@quiz.to_canvas[:title]).to eq @quiz.title
      expect(@quiz.to_canvas[:question_count]).to eq @quiz.questions.count
      expect(@quiz.to_canvas[:time_limit]).to eq @quiz.time_limit
      expect(@quiz.to_canvas[:quiz_type]).to eq "assignment"
      expect(@quiz.to_canvas[:allowed_attempts]).to eq 1
      expect(@quiz.to_canvas[:description]).to eq @quiz.description
    end
  end

  describe "get_question_paragraphs" do
    it "returns the paragraphs for just the questions" do
      question_paragraphs = Word2Quiz::Quiz.get_question_paragraphs(@paragraphs)
      expect(question_paragraphs.count).to eq 10
    end
  end

  describe "questions_as_canvas" do
    before do
      @quiz = Word2Quiz::Quiz.new(
        title: "title",
        time_limit: 120,
        description: "description",
      )

      @quiz.questions = FactoryGirl.create_list(:question, 5)
      @quiz.questions.each do |question|
        allow(question).to receive(:to_h).and_return({})
      end
    end
    it "calls to_canvas on all of the questions" do
      @quiz.questions.each do |question|
        expect(question).to receive(:to_canvas).and_return({})
      end

      expect(@quiz.questions_as_canvas).to eq (0...5).map { {} }
    end
  end
end
