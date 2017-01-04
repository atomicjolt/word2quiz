require "factory_girl"
require "ostruct"

LETTERS = ("a".."c").to_a.freeze

FactoryGirl.define do
  factory :question_start_paragraph, class: OpenStruct do
    text "Multiple Choice"
    to_html "<p>Multiple Choice</p>"
  end

  factory :question_end_paragraph, class: OpenStruct do
    text "End of examination"
    to_html "<p>End of examination</p>"
  end

  factory :question_paragraph, class: OpenStruct do
    sequence(:text) { |n| "#{n}. asdf" }
    sequence(:to_html) { |n| "<p>#{n}. asdf</p>" }
  end

  factory :answer_paragraph, class: OpenStruct do
    sequence(:text) { |n| "#{LETTERS[(n - 1) % 3]}. fdsa" }
    sequence(:to_html) { |n| "<p>#{LETTERS[(n - 1) % 3]}. fdsa</p>" }
  end

  factory :description_paragraph, class: OpenStruct do
    sequence(:text) { |n| "Quiz Description #{n}" }
    sequence(:to_html) { |n| "<p>Quiz Description #{n}</p>" }
  end

  factory :time_paragraph, class: OpenStruct do
    text "This examination consists of one session not to exceed two hours"
    to_html "<p>This examination consists of one session not to exceed two " +
      "hours</p>"
  end

  factory :doc_question, class: OpenStruct do
    paragraphs []

    after(:create) do |doc_question|
      # Reinitialize array because it is only empty the very first time.
      doc_question.paragraphs = []
      doc_question.paragraphs << FactoryGirl.create(:question_paragraph)
      doc_question.paragraphs << FactoryGirl.create(:description_paragraph)
      doc_question.paragraphs |= FactoryGirl.create_list(:answer_paragraph, 3)
    end
  end

  factory :doc_quiz, class: OpenStruct do
    paragraphs []

    after(:create) do |doc_quiz|
      doc_quiz.paragraphs = []
      doc_quiz.paragraphs |= FactoryGirl.create_list(:description_paragraph, 10)
      doc_quiz.paragraphs << FactoryGirl.create(:time_paragraph)
      doc_quiz.paragraphs << FactoryGirl.create(:question_start_paragraph)

      10.times do
        doc_quiz.paragraphs << FactoryGirl.create(:question_paragraph)
        doc_quiz.paragraphs |= FactoryGirl.create_list(:answer_paragraph, 3)
      end

      doc_quiz.paragraphs << FactoryGirl.create(:question_end_paragraph)
    end
  end
end
