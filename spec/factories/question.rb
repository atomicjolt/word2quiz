require "factory_girl"
require "ostruct"

FactoryGirl.define do
  factory :question, class: OpenStruct do
    sequence(:text) { |n| "<p>#{n}. asdf</p>" }
    answers []

    after_create do |question|
      question.answers.concat(FactoryGirl.create_list(:answer, 3))
    end
  end
end
