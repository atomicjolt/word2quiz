require "factory_girl"
require "ostruct"

LETTERS = ("a".."c").to_a.freeze

FactoryGirl.define do
  factory :answer, class: OpenStruct do
    sequence(:text) { |n| "<p>#{LETTERS[(n - 1) % 3]}. fdsa</p>" }
    sequence(:correct) { |n| (n % 2).zero? }
  end
end
