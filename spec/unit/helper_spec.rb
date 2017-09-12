require "rspec"
require "rspec/mocks"
require "word_2_quiz/helpers"
require "rubygems"
require "factory_girl"

describe Word2Quiz::Helpers do
  before do
    @fake_quiz = FactoryGirl.create(:doc_quiz)
  end
  describe "map_to_boundaries" do
    before do
      @question =
        ["1. First line", "Second Line", "Multiple Choice", "A. Yes",
         "B. No", "C. Maybe", "D. So"]
    end
    it "Should return an entire paragraph" do
      paragraph = Word2Quiz::Helpers::map_to_boundaries(indexes: [0, 2],
                                                        paragraphs: @question)
      expect(paragraph[0]).to eq(["1. First line", "Second Line"])
    end
  end

  describe "get_quiz_duration" do
    before do
      @time_paragraph = FactoryGirl.create(:time_paragraph)
    end
    it "Should get quiz duration" do
      time_duration = Word2Quiz::Helpers::get_quiz_duration([@time_paragraph])
      expect(time_duration).to eq(120)
    end
  end

  describe "get_quiz_title" do
    it "Should get quiz title" do
      title = Word2Quiz::Helpers::get_quiz_title(@fake_quiz.paragraphs)
      expect(title).not_to be_empty
    end
  end

  describe "Should get quiz description" do
    it "Should get quiz description" do
      description =
        Word2Quiz::Helpers::get_quiz_description(@fake_quiz.paragraphs)
      expect(description).not_to be_empty
    end
  end

  describe "get_question_number" do
    before do
      @fake_question = FactoryGirl.create(:question_paragraph)
    end
    it "Should get question number" do
      question_number =
        Word2Quiz::Helpers::get_question_number([@fake_question])
      expect(question_number.to_i).to be_kind_of(Integer)
    end
  end

  describe "get_question_start_index" do
    before do
      @question_start_index = 11
    end
    it "Should get question start index" do
      start_index =
        Word2Quiz::Helpers::get_question_start_index(@fake_quiz.paragraphs)
      expect(start_index.to_i).to eq(@question_start_index)
    end
  end

  describe "get_question_indexes" do
    before do
      @expected_index = 25
    end
    it "Should get question end index" do
      end_index =
        Word2Quiz::Helpers::get_question_end_index(@fake_quiz.paragraphs)
      expect(end_index.to_i).to eq(@expected_index)
    end
  end

  describe "get_question_indexes" do
    before do
      @expected_indicies = [12, 16, 17, 18, 19, 20, 21, 22, 23, 24]
    end
    it "Should get question indexes" do
      indicies = Word2Quiz::Helpers::get_question_indexes(@fake_quiz.paragraphs)
      expect(indicies).to eq(@expected_indicies)
    end
  end

  describe "strip_blanks" do
    before do
      @spacey_paragraphs = FactoryGirl.create(:spacey_paragraphs)
      @size_after_strip = 1
    end
    it "Should strip leading and trailing whitespace" do
      stripped = Word2Quiz::Helpers::strip_blanks(@spacey_paragraphs.paragraphs)
      expect(stripped.length).to eq(@size_after_strip)
    end
  end
end
